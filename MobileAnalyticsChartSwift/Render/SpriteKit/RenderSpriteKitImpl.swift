import SpriteKit

public class RenderSpriteKitImpl: SKScene {

    public weak var moduleOutput: RenderDrawerModuleOutput?

    // MARK: - Init data

    private var chartsConfiguration: [ChartRenderConfiguration]
    private var configuration: RenderConfiguration
    private var calculator: Calculator
    private let analyticsYAxisLocalizationFactory: AnalyticsYAxisLocalizationFactory
    private let analyticsDefinitionFactory: AnalyticsDefinitionFactory

    // MARK: - Init

    public init(
        chartsConfiguration: [ChartRenderConfiguration],
        configuration: RenderConfiguration,
        calculator: Calculator,
        analyticsYAxisLocalizationFactory: AnalyticsYAxisLocalizationFactory,
        analyticsDefinitionFactory: AnalyticsDefinitionFactory
    ) {
        self.chartsConfiguration = chartsConfiguration
        self.configuration = configuration
        self.calculator = calculator
        self.analyticsYAxisLocalizationFactory = analyticsYAxisLocalizationFactory
        self.analyticsDefinitionFactory = analyticsDefinitionFactory
        super.init(size: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Gesture recognizer

    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePan)
        )
        gesture.maximumNumberOfTouches = 1
        return gesture
    }()

    private lazy var pinchGestureRecognizer: UIPinchGestureRecognizer = {
        let gesture = UIPinchGestureRecognizer(
            target: self,
            action: #selector(handlePinch)
        )
        return gesture
    }()

    private lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress)
        )
        gesture.allowableMovement = 20
        gesture.minimumPressDuration = 0.2
        return gesture
    }()

    // MARK: - Animations

    private var lastUpdateTime: TimeInterval = 0.0

    private var dt: TimeInterval = 0.0

    /// Duration of animation redraw chart.
    private var duration: TimeInterval = 0.0

    /// How much is left to animate.
    private var leftDuration: TimeInterval = 0.0

    /// Current min value for animation.
    private var currentMinValue: CGFloat = 0

    /// Current max value for animation.
    private var currentMaxValue: CGFloat = 0

    /// Difference between new and current min values.
    private var diffMinValue: CGFloat = 0

    /// Difference between new and current max values.
    private var diffMaxValue: CGFloat = 0

    // MARK: - Charts nodes

    private var chartsNode: [RoundNode] = []

    private var chartsClipNode: [SKCropNode] = []

    private var gradients: [SKSpriteNode] = []

    // MARK: - Definitions nodes

    private var definitionNode = SquareNode()

    private var definitionsPoint: [RoundNode] = []

    private var definitionView = SKShapeNode()

    private var definitionDateLabel = SKLabelNode()

    private var definitionValueLabels: [SKLabelNode] = []

    private var definitionChartLines: [SKShapeNode] = []

    // MARK: - Range label node

    private var rangeLabel = SKLabelNode()

    // MARK: - X Axis nodes

    private var xAxisLabels = BasicNode()

    // MARK: - Y Axis nodes

    private var yAxis = SquareNode()

    private var yAxisLabels = BasicNode()

    private var zeroLine = SquareNode()

    // MARK: - Addition

    private var handlerActivated = false

    private var previousLocation = CGPoint()

    // MARK: - Frames

    private var chartFrame: CGRect = .zero

    private var gradientFrame: CGRect = .zero

    private var xAxisFrame: CGRect = .zero

    private var yAxisLabelHeight: CGFloat = 0
}

// MARK: - Setup

extension RenderSpriteKitImpl {
    private func setup() {
        self.scaleMode = .aspectFill
        setupRenderNodes()
        setupChartsNodes()
        setupAnimation()
        setupZPositions()
        setupNodes()
        setupConfiguration(configuration)
        setupChartsConfiguration(chartsConfiguration)
    }

    private func setupRenderNodes() {
        [
            rangeLabel,
            yAxis,
            yAxisLabels,
            zeroLine,
            xAxisLabels,
            definitionNode,
            definitionView,
        ].forEach(addChild)
    }

    private func setupChartsNodes() {
        for _ in 0 ..< chartsConfiguration.count {
            let chartNode = RoundNode()
            chartsNode.append(chartNode)

            let gradient = SKSpriteNode()
            gradients.append(gradient)

            let chartClipNode = SKCropNode()
            chartClipNode.addChild(gradient)
            chartsClipNode.append(chartClipNode)

            let definitionPoint = RoundNode()
            definitionsPoint.append(definitionPoint)

            let definitionValueLabel = SKLabelNode()
            definitionValueLabels.append(definitionValueLabel)

            let definitionChartLine = SKShapeNode()
            definitionChartLines.append(definitionChartLine)
        }

        chartsNode.forEach(addChild)
        chartsClipNode.forEach(addChild)

        definitionsPoint.forEach {
            definitionNode.addChild($0)
        }
        definitionView.addChild(definitionDateLabel)
        definitionValueLabels.forEach {
            definitionView.addChild($0)
        }
        definitionChartLines.forEach {
            definitionView.addChild($0)
        }
    }

    private func removeChartsNodes() {
        chartsNode.forEach { $0.removeFromParent() }
        chartsClipNode.forEach { $0.removeFromParent() }
        gradients.forEach { $0.removeFromParent() }
        definitionsPoint.forEach { $0.removeFromParent() }
        definitionValueLabels.forEach { $0.removeFromParent() }
        definitionChartLines.forEach { $0.removeFromParent() }
        definitionDateLabel.removeFromParent()

        chartsNode.removeAll()
        chartsClipNode.removeAll()
        gradients.removeAll()
        definitionsPoint.removeAll()
        definitionValueLabels.removeAll()
        definitionChartLines.removeAll()
    }

    private func setupAnimation() {
        lastUpdateTime = 0.0
        dt = 0.0
        leftDuration = 0.0
        diffMinValue = 0.0
        diffMaxValue = 0.0
        if let minValue = calculator.minValue {
            currentMinValue = minValue
        }
        if let maxValue = calculator.maxValue {
            currentMaxValue = maxValue
        }
    }

    private func setupZPositions() {
        chartsClipNode.forEach {
            $0.zPosition = 1
        }

        yAxis.zPosition = 2
        zeroLine.zPosition = 2

        chartsNode.forEach {
            $0.zPosition = 3
        }

        definitionNode.zPosition = 4

        definitionsPoint.forEach {
            $0.zPosition = 1
        }

        rangeLabel.zPosition = 5

        definitionView.zPosition = 6
        definitionDateLabel.zPosition = 7
        definitionValueLabels.forEach {
            $0.zPosition = 7
        }
        definitionChartLines.forEach {
            $0.zPosition = 7
        }
    }

    private func setupNodes() {
        setupChartNode()
        setupDefinitionNode()
        setupDefinitionView()
        setupRangeLabel()
        setupXAxisLabels()
        setupYAxisLines()
        setupYAxisLabels()
        setupZeroLine()
    }

    private func setupChartNode() {
        chartsNode.forEach {
            $0.blendMode = .alpha
        }
    }

    private func setupRangeLabel() {
        rangeLabel.horizontalAlignmentMode = .center
        rangeLabel.verticalAlignmentMode = .top
    }

    private func setupDefinitionNode() {
        definitionNode.blendMode = .alpha
        definitionsPoint.forEach {
            $0.blendMode = .alpha
        }
    }

    private func setupDefinitionView() {
        definitionDateLabel.horizontalAlignmentMode = .left
        definitionDateLabel.verticalAlignmentMode = .top
        definitionView.lineWidth = 0
        definitionValueLabels.forEach {
            $0.horizontalAlignmentMode = .left
            $0.verticalAlignmentMode = .top
        }
        definitionChartLines.forEach {
            $0.path = CGPath(
                rect: .init(x: 0, y: 0, width: 14, height: 2),
                transform: nil
            )
            $0.lineWidth = 0
        }
    }

    private func setupXAxisLabels() {
        xAxisLabels.blendMode = .multiply
    }

    private func setupYAxisLines() {
        yAxis.blendMode = .alpha
    }

    private func setupYAxisLabels() {
        yAxisLabels.blendMode = .multiply
    }

    private func setupZeroLine() {
        zeroLine.blendMode = .alpha
    }
}

// MARK: - Configuration

extension RenderSpriteKitImpl {

    private func setupConfiguration(
        _ configuration: RenderConfiguration
    ) {
        self.backgroundColor = configuration.backgroundColor
        configureAnimation(configuration.animation)
        if let configurationRangeLabel = configuration.rangeLabel {
            configureRangeLabel(configurationRangeLabel)
        }
        if let configurationYAxis = configuration.yAxis {
            configureYAxis(configurationYAxis)
        }
        if let configurationZeroLine = configuration.zeroLine {
            configureZeroLine(configurationZeroLine)
        }
        if let configurationDefinition = configuration.definition {
            configureDefinitionNode(configurationDefinition)
            definitionsPoint.forEach {
                configureDefinitionPointFillColor(
                    fillColor: configuration.backgroundColor,
                    definitionPoint: $0
                )
            }
        }
    }

    private func setupChartsConfiguration(
        _ chartsConfiguration: [ChartRenderConfiguration]
    ) {
        for (index, chartConfiguration) in chartsConfiguration.enumerated() {
            configureChartNode(
                chartConfiguration.path,
                chartNode: chartsNode[index]
            )

            if let configurationDefinition = configuration.definition {
                configureDefinitionPoint(
                    strokeColor: chartConfiguration.path.color,
                    fillColor: configuration.backgroundColor,
                    definitionPoint: definitionsPoint[index],
                    definitionChartLine: definitionChartLines[index]
                )
                configureDefinitionNode(configurationDefinition)
            }
        }
    }

    private func configureAnimation(
        _ configuration: ChartAnimation
    ) {
        duration = configuration.redrawDuration
    }

    private func configureChartNode(
        _ configuration: ChartPath,
        chartNode: RoundNode
    ) {
        chartNode.strokeColor = configuration.color
    }

    private func configureRangeLabel(
        _ configuration: ChartRangeLabel
    ) {
        rangeLabel.fontName = configuration.font.familyName
        rangeLabel.fontSize = configuration.font.pointSize
        rangeLabel.fontColor = configuration.color
    }

    private func configureDefinitionNode(
        _ configuration: ChartDefinition
    ) {
        definitionNode.strokeColor = configuration.line.color
        definitionNode.lineWidth = configuration.line.width
        definitionView.fillColor = configuration.view.backgroundColor
        definitionDateLabel.fontName = configuration.view.dateLabelFont.familyName
        definitionDateLabel.fontSize = configuration.view.dateLabelFont.pointSize
        definitionDateLabel.fontColor = configuration.view.dateLabelColor
        definitionValueLabels.forEach {
            $0.fontName = configuration.view.valueLabelFont.familyName
            $0.fontSize = configuration.view.valueLabelFont.pointSize
            $0.fontColor = configuration.view.valueLabelColor
        }
    }

    private func configureDefinitionPoint(
        strokeColor: UIColor,
        fillColor: UIColor,
        definitionPoint: RoundNode,
        definitionChartLine: SKShapeNode
    ) {
        definitionPoint.strokeColor = strokeColor
        definitionChartLine.fillColor = strokeColor
        configureDefinitionPointFillColor(
            fillColor: fillColor,
            definitionPoint: definitionPoint
        )
    }

    private func configureDefinitionPointFillColor(
        fillColor: UIColor,
        definitionPoint: RoundNode
    ) {
        definitionPoint.fillColor = fillColor
    }

    private func configureYAxis(
        _ configuration: ChartYAxis
    ) {
        yAxis.strokeColor = configuration.lineColor
        yAxis.lineWidth = configuration.lineWidth
        yAxisLabelHeight = configuration.labelFont.lineHeight
    }

    private func configureZeroLine(
        _ configuration: ChartZeroLine
    ) {
        zeroLine.strokeColor = configuration.color
        zeroLine.lineWidth = configuration.width
    }

    private func configureGesture(
        view: SKView,
        configuration: ChartGestureState
    ) {
        view.gestureRecognizers?.removeAll()

        if configuration.swipeIsActive {
            view.addGestureRecognizer(panGestureRecognizer)
        }

        if configuration.pinchIsActive {
            view.addGestureRecognizer(pinchGestureRecognizer)
        }

        if configuration.handleIsActive {
            view.addGestureRecognizer(longPressGestureRecognizer)
        }
    }

    private func configureGradient(
        frame: CGRect,
        configuration: Gradient?,
        gradient: SKSpriteNode
    ) {
        guard let configuration = configuration else {
            return
        }

        let textureSize = CGSize(
            width: frame.width / 2,
            height: frame.height / 2
        )
        let texture = SKTexture(
            size: textureSize,
            color1: CIColor(color: configuration.firstColor),
            color2: CIColor(color: configuration.secondColor),
            direction: configuration.direction
        )
        texture.filteringMode = .linear

        gradient.size = frame.size
        gradient.position = CGPoint(x: frame.midX, y: frame.midY)
        gradient.texture = texture
    }
}

// MARK: - Update view

extension RenderSpriteKitImpl {

    public override func didMove(
        to view: SKView
    ) {
        super.didMove(to: view)
        updateView(view)
    }

    private func updateView(
        _ view: SKView
    ) {
        removeXAxisLabels()
        updateSize(view.frame.size)
        configureGesture(
            view: view,
            configuration: configuration.gestureState
        )
        for (index, chartConfiguration) in chartsConfiguration.enumerated() {
            configureGradient(
                frame: gradientFrame,
                configuration: chartConfiguration.gradient,
                gradient: gradients[index]
            )
        }

        drawYAxis()
        drawRangeLabel()
        redraw()
    }

    private func removeXAxisLabels() {
        xAxisLabels.removeAllActions()
        xAxisLabels.removeAllChildren()
    }

    private func updateSize(
        _ size: CGSize
    ) {
        self.size = size

        let rangeLabelPosition = makeRangeLabelPosition(
            size: size
        )
        rangeLabel.position = rangeLabelPosition

        let xAxisFrame = makeXAxisFrame(
            size: size
        )
        self.xAxisFrame = xAxisFrame

        gradientFrame = makeGradientFrame(
            size: size,
            xAxisFrame: xAxisFrame
        )

        chartFrame = makeChartFrame(
            size: size,
            xAxisFrame: xAxisFrame,
            rangeLabelPositionY: rangeLabelPosition.y
        )
    }
}

// MARK: - Update

extension RenderSpriteKitImpl {

    public override func update(_ currentTime: TimeInterval) {
        dt = currentTime - lastUpdateTime
        lastUpdateTime = currentTime

        if dt > 1 {
            if let minValue = calculator.minValue,
               currentMinValue != minValue {
                currentMinValue = minValue
            }
            if let maxValue = calculator.maxValue,
               currentMaxValue != maxValue {
                currentMaxValue = maxValue
            }
            redraw()
            return
        }

        if leftDuration > 0 {
            leftDuration -= dt
            if leftDuration < 0 {
                dt += leftDuration
            }
            currentMinValue += diffMinValue / CGFloat(duration / dt)
            currentMaxValue += diffMaxValue / CGFloat(duration / dt)
            redraw()
        }
    }
}

// MARK: - Actions

extension RenderSpriteKitImpl {

    @objc
    func handlePan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            previousLocation = recognizer.location(in: self.view)
        case .changed:
            let location = recognizer.location(in: self.view)
            let deltaLocation = CGFloat(location.x - previousLocation.x)
            previousLocation = location

            guard let rangeValue = calculator.makeRangeValue(
                deltaLocation: deltaLocation,
                frameWidth: chartFrame.width
            ) else { return }

            moduleOutput?.didHandlePan(deltaLocation: deltaLocation)
            changeRangeValue(rangeValue)
        default:
            break
        }
    }

    @objc
    func handlePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }

        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let scale = gestureRecognizer.scale
            gestureRecognizer.scale = 1.0
            guard let rangeValue = calculator.makeRangeValue(
                scale: scale
            ) else { return }

            moduleOutput?.didHandlePinch(scale: scale)
            changeRangeValue(rangeValue)
        }
    }

    @objc
    func handleLongPress(_ recognizer: UIPanGestureRecognizer) {
        guard calculator.isAlwaysDrawDefinition() == false else { return }

        switch recognizer.state {
        case .began, .changed:
            previousLocation = recognizer.location(in: self.view)
            handlerActivated = true
            moduleOutput?.didHandleLongPress()
            drawDefinition()
        case .ended:
            endHandleDefinition()
        default:
            break
        }
    }

    private func endHandleDefinition() {
        handlerActivated = false
        setHiddenDefinition(isHidden: true)
    }

    private func changeRangeValue(
        _ rangeValue: RangeValue<CGFloat>
    ) {

        moduleOutput?.didChangeRangeValue(
            rangeValue: rangeValue
        )

        guard let minValue = calculator.minValue,
              let maxValue = calculator.maxValue else {
            return
        }

        calculator.setRangeValue(rangeValue: rangeValue)
        diffMinValue = minValue - currentMinValue
        diffMaxValue = maxValue - currentMaxValue
        if diffMinValue != 0 || diffMaxValue != 0 {
            leftDuration = duration
        } else {
            redraw()
        }
    }
}

// MARK: - RenderDrawerModuleInput
extension RenderSpriteKitImpl: RenderDrawerModuleInput {

    public func setConfiguration(
        _ configuration: RenderConfiguration
    ) {
        endHandleDefinition()
        self.configuration = configuration
        setupConfiguration(configuration)
        if let view = view {
            updateView(view)
        }
    }

    public func setChartsConfiguration(
        _ chartsConfiguration: [ChartRenderConfiguration]
    ) {
        self.chartsConfiguration = chartsConfiguration
        endHandleDefinition()
        removeChartsNodes()
        setupChartsNodes()
        setupZPositions()
        setupNodes()
        setupChartsConfiguration(chartsConfiguration)
        if let view = view {
            updateView(view)
        }
    }

    public func setCalculator(
        _ calculator: Calculator
    ) {
        endHandleDefinition()
        self.calculator = calculator
        setupAnimation()
        if let view = view {
            updateView(view)
        }
    }

    public func fadeInChart() {
        chartsNode.forEach {
            $0.alpha = 0
        }
        gradients.forEach {
            $0.alpha = 0
        }
        definitionsPoint.forEach {
            $0.alpha = 0
        }

        let fadeInAction = SKAction.fadeIn(withDuration: configuration.fadeInDuration)
        fadeInAction.timingMode = .easeOut

        chartsNode.forEach {
            $0.run(fadeInAction)
        }
        gradients.forEach {
            $0.run(fadeInAction)
        }
        definitionsPoint.forEach {
            $0.run(fadeInAction)
        }
    }

    public func fadeOutChart() {
        let currentCharts = chartsNode.compactMap { $0.copy() as? SKShapeNode }
        let currentDefinitionsPoint = definitionsPoint.compactMap { $0.copy() as? SKSpriteNode }
        let currentChartsClipNode = chartsClipNode.compactMap { $0.copy() as? SKCropNode }

        let fadeOutAction = SKAction.fadeOut(withDuration: configuration.fadeOutDuration)
        fadeOutAction.timingMode = .easeIn
        let removeAction = SKAction.removeFromParent()
        let squenceAction = SKAction.sequence([
            fadeOutAction,
            removeAction,
        ])

        currentCharts.forEach {
            addChild($0)
            $0.run(squenceAction)
        }
        currentChartsClipNode.enumerated().forEach {
            addChild($0.element)
            $0.element.run(squenceAction)
        }
        currentDefinitionsPoint.forEach {
            addChild($0)
            $0.run(squenceAction)
        }
    }

    public func startFade() {
        startChartFade()
        startGradientFade()
        startDefinitionPointFade()
    }

    public func stopFade() {
        for (index, chartConfiguration) in chartsConfiguration.enumerated() {
            if let gradientFadeKey = chartConfiguration.gradient?.fadeAnimation.key {
                gradients[index].removeAction(forKey: gradientFadeKey)
            }

            chartsNode[index].removeAction(forKey: chartConfiguration.path.fadeAnimation.key)
        }

        if let definitionPointFadeKey = configuration.definition?.fadeAnimation.key {
            definitionsPoint.forEach { $0.removeAction(forKey: definitionPointFadeKey) }
        }
    }

    private func startChartFade() {
        for (index, chartConfiguration) in chartsConfiguration.enumerated() {
            let fadeAnimation = chartConfiguration.path.fadeAnimation

            guard chartsNode[index].action(forKey: fadeAnimation.key) == nil else { continue }

            let startAction = SKAction.strokeColorTransitionAction(
                fromColor: chartsNode[index].strokeColor,
                toColor: fadeAnimation.fadeOutColor,
                duration: fadeAnimation.startDuration
            )

            let fadeOutAction = SKAction.strokeColorTransitionAction(
                fromColor: fadeAnimation.fadeOutColor,
                toColor: fadeAnimation.fadeInColor,
                duration: fadeAnimation.fadeOutDuration
            )
            fadeOutAction.timingMode = .easeOut

            let fadeInAction = SKAction.strokeColorTransitionAction(
                fromColor: fadeAnimation.fadeInColor,
                toColor: fadeAnimation.fadeOutColor,
                duration: fadeAnimation.fadeInDuration
            )
            fadeInAction.timingMode = .easeIn

            let chartFadeAction = SKAction.fadeAction(
                startAction: startAction,
                fadeOutAction: fadeOutAction,
                fadeInAction: fadeInAction
            )
            chartsNode[index].run(chartFadeAction, withKey: fadeAnimation.key)
        }
    }

    private func startGradientFade() {
        for (index, chartConfiguration) in chartsConfiguration.enumerated() {
            guard let gradientConfiguration = chartConfiguration.gradient,
                  gradients[index].action(forKey: gradientConfiguration.fadeAnimation.key) == nil else { continue }

            let fadeAnimation = gradientConfiguration.fadeAnimation
            let startAction = SKAction.gradientColorTransitionAction(
                fromColor: gradientConfiguration.secondColor,
                toColor: fadeAnimation.fadeOutColor,
                duration: fadeAnimation.startDuration
            )

            let fadeOutAction = SKAction.gradientColorTransitionAction(
                fromColor: fadeAnimation.fadeOutColor,
                toColor: fadeAnimation.fadeInColor,
                duration: fadeAnimation.fadeOutDuration
            )
            fadeOutAction.timingMode = .easeOut

            let fadeInAction = SKAction.gradientColorTransitionAction(
                fromColor: fadeAnimation.fadeInColor,
                toColor: fadeAnimation.fadeOutColor,
                duration: fadeAnimation.fadeInDuration
            )
            fadeInAction.timingMode = .easeIn

            let gradientFadeAction = SKAction.fadeAction(
                startAction: startAction,
                fadeOutAction: fadeOutAction,
                fadeInAction: fadeInAction
            )
            gradients[index].run(gradientFadeAction, withKey: fadeAnimation.key)
        }
    }

    private func startDefinitionPointFade() {
        guard let definitionConfiguration = configuration.definition else { return }

        for index in chartsConfiguration.indices {
            guard definitionsPoint[index].action(
                    forKey: definitionConfiguration.fadeAnimation.key
                  ) == nil else { continue }

            let fadeAnimation = definitionConfiguration.fadeAnimation
            let startAction = SKAction.strokeColorTransitionAction(
                fromColor: chartsNode[index].strokeColor,
                toColor: fadeAnimation.fadeOutColor,
                duration: fadeAnimation.startDuration
            )

            let fadeOutAction = SKAction.strokeColorTransitionAction(
                fromColor: fadeAnimation.fadeOutColor,
                toColor: fadeAnimation.fadeInColor,
                duration: fadeAnimation.fadeOutDuration
            )
            fadeOutAction.timingMode = .easeOut

            let fadeInAction = SKAction.strokeColorTransitionAction(
                fromColor: fadeAnimation.fadeInColor,
                toColor: fadeAnimation.fadeOutColor,
                duration: fadeAnimation.fadeInDuration
            )
            fadeInAction.timingMode = .easeIn

            let definitionPointFadeAction = SKAction.fadeAction(
                startAction: startAction,
                fadeOutAction: fadeOutAction,
                fadeInAction: fadeInAction
            )
            definitionsPoint[index].run(definitionPointFadeAction, withKey: fadeAnimation.key)
        }
    }
}

// MARK: - RenderDrawer
extension RenderSpriteKitImpl: RenderDrawer {
    public func redraw() {
        drawChart()
        drawXAxis()
        drawYAxisLabels()
        drawZeroLine()
        drawDefinition()
    }

    public func drawChart() {
        let chartsPoints = calculator.makeChartsPoints(
            frame: chartFrame,
            chartMargins: configuration.chartMargins,
            minValue: currentMinValue,
            maxValue: currentMaxValue
        )

        for (index, chartConfiguration) in chartsConfiguration.enumerated() {
            let chartPoints: [CGPoint]
            if chartsPoints.indices.contains(index) {
                chartPoints = chartsPoints[index]
            } else {
                chartPoints = []
            }

            let lineWidth = calculator.calculateLineWidth(
                index: index,
                minLineWidth: chartConfiguration.path.minWidth,
                maxLineWidth: chartConfiguration.path.maxWidth
            )
            chartsNode[index].lineWidth = lineWidth

            let path: UIBezierPath
            switch chartConfiguration.path.type {
            case .linear:
                path = LinearPath(points: chartPoints)
            case .quadratic:
                path = QuadraticPath(points: chartPoints)
            case .horizontalQuadratic:
                path = HorizontalQuadraticPath(points: chartPoints)
            }
            chartsNode[index].path = path.cgPath

            guard chartConfiguration.gradient != nil,
                  let copyPath = path.copy() as? UIBezierPath,
                  copyPath.isEmpty == false else {
                gradients[index].isHidden = true
                continue
            }

            gradients[index].isHidden = false
            copyPath.addLine(to: CGPoint(x: chartFrame.maxX, y: self.frame.minY))
            copyPath.addLine(to: CGPoint(x: chartFrame.minX, y: self.frame.minY))
            let maskNode = RoundNode()
            maskNode.lineWidth = lineWidth
            maskNode.path = copyPath.cgPath
            maskNode.fillColor = .white
            chartsClipNode[index].maskNode = maskNode
        }
    }

    public func drawXAxis() {
        guard let configurationXAxis = configuration.xAxis else { return }

        let xAxisValues = calculator.makeXAxis(
            frame: xAxisFrame,
            leftInset: configurationXAxis.margins.left,
            rightInset: configurationXAxis.margins.right,
            minCount: configurationXAxis.minCountLabels,
            zoomFactor: configurationXAxis.zoomFactorLabels
        )

        xAxisLabels.removeAllChildren()
        xAxisValues.forEach {
            let dateText = configurationXAxis.dateFormatter.string(from: $0.date)
            let label = SKLabelNode(text: dateText)
            label.blendMode = .multiply
            label.zPosition = 2
            label.fontSize = configurationXAxis.labelFont.pointSize
            label.fontName = configurationXAxis.labelFont.familyName
            label.horizontalAlignmentMode = .center
            label.verticalAlignmentMode = .bottom
            label.fontColor = SKColor(ciColor: CIColor(color: configurationXAxis.labelColor))
            label.position = $0.position
            xAxisLabels.addChild(label)
        }
    }

    public func drawYAxis() {
        guard let configurationYAxis = configuration.yAxis else { return }

        let linesYPositions = calculator.makeYAxisLines(
            frame: chartFrame,
            labelHeight: yAxisLabelHeight,
            labelInsets: configurationYAxis.labelInsets,
            linesCount: configurationYAxis.linesCount
        )
        let path = CGMutablePath()
        for lineYPosition in linesYPositions {
            path.move(to: lineYPosition.start)
            path.addLine(to: lineYPosition.end)
            path.closeSubpath()
        }
        yAxis.path = path
    }

    public func drawYAxisLabels() {
        guard let configurationYAxis = configuration.yAxis else { return }

        let yAxisValues = calculator.makeYAxisValues(
            frame: chartFrame,
            chartMargins: configuration.chartMargins,
            labelHeight: yAxisLabelHeight,
            labelInsets: configurationYAxis.labelInsets,
            linesCount: configurationYAxis.linesCount
        )
        yAxisLabels.removeAllChildren()
        yAxisValues.forEach {
            let text = analyticsYAxisLocalizationFactory.makeYAxisText($0.value)
            let label = SKLabelNode(text: text)
            label.blendMode = .multiply
            label.zPosition = 2
            label.fontSize = configurationYAxis.labelFont.pointSize
            label.fontName = configurationYAxis.labelFont.familyName
            label.horizontalAlignmentMode = .left
            label.verticalAlignmentMode = .bottom
            label.fontColor = SKColor(ciColor: CIColor(color: configurationYAxis.labelColor))
            label.position = $0.position
            yAxisLabels.addChild(label)
        }
    }

    public func drawZeroLine() {
        guard let configurationZeroLine = configuration.zeroLine else { return }

        if let zeroLinePosition = calculator.makeZeroLine(
            frame: chartFrame,
            chartMargins: configuration.chartMargins,
            minValue: currentMinValue,
            maxValue: currentMaxValue
        ) {
            let path = CGMutablePath()
            path.move(to: zeroLinePosition.start)
            path.addLine(to: zeroLinePosition.end)
            path.closeSubpath()
            zeroLine.path = path.copy(dashingWithPhase: 0, lengths: [10, 10])
        } else {
            zeroLine.path = nil
        }
    }

    public func drawRangeLabel() {
        guard let configurationRangeLabel = configuration.rangeLabel,
              let dates = calculator.makeRangeDates() else {
            rangeLabel.text = nil
            return
        }

        let rangeText: String
        let dateFormatter = configurationRangeLabel.dateFormatter
        let startDateText = dateFormatter.string(from: dates.start)
        if let endDate = dates.end {
            let endDateText = dateFormatter.string(from: endDate)
            rangeText = "\(startDateText) - \(endDateText)"
        } else {
            rangeText = "\(startDateText)"
        }

        rangeLabel.text = rangeText
    }

    public func drawDefinition() {
        guard handlerActivated || calculator.isAlwaysDrawDefinition(),
              let definitionConfiguration = configuration.definition else {
            setHiddenDefinition(isHidden: true)
            return
        }

        guard let definitionValues = calculator.makeDefinition(
            frame: chartFrame,
            chartMargins: configuration.chartMargins,
            definitionPosition: previousLocation,
            minValue: currentMinValue,
            maxValue: currentMaxValue
        ) else {
            definitionsPoint.forEach { $0.isHidden = true }
            return
        }

        var maxDefinitionLabelWidth: CGFloat = 0

        for (index, chartConfiguration) in chartsConfiguration.enumerated() {
            let pointRadius = calculator.calculateLineWidth(
                index: index,
                minLineWidth: definitionConfiguration.point.minRadius,
                maxLineWidth: definitionConfiguration.point.maxRadius
            )
            let pointLineWidth = calculator.calculateLineWidth(
                index: index,
                minLineWidth: chartConfiguration.path.minWidth,
                maxLineWidth: chartConfiguration.path.maxWidth
            )

            let pointWidth = pointRadius * 2
            let pointPosition = definitionValues.chartValues[index].pointPosition
            let pointRect = CGRect(
                x: pointPosition.x - pointWidth / 2,
                y: pointPosition.y - pointWidth / 2,
                width: pointWidth,
                height: pointWidth
            )
            definitionsPoint[index].path = UIBezierPath(ovalIn: pointRect).cgPath
            definitionsPoint[index].lineWidth = pointLineWidth
            definitionsPoint[index].isHidden = false

            definitionValueLabels[index].text = analyticsDefinitionFactory.makeDefinitionText(
                definitionValues.chartValues[index].value,
                unit: chartConfiguration.unit
            )
            maxDefinitionLabelWidth = max(
                maxDefinitionLabelWidth,
                definitionValueLabels[index].frame.width
            )
        }

        definitionDateLabel.text = definitionConfiguration.view.dateFormatter.string(from: definitionValues.date)
        maxDefinitionLabelWidth = max(
            maxDefinitionLabelWidth,
            definitionDateLabel.frame.width
        )

        drawDefinitionView(
            definitionConfiguration: definitionConfiguration,
            linePositionX: definitionValues.linePosition.start.x,
            maxDefinitionLabelWidth: maxDefinitionLabelWidth
        )

        let linePoints = [
            definitionValues.linePosition.start,
            definitionValues.linePosition.end,
        ]
        definitionNode.path = LinearPath(points: linePoints).cgPath

        setHiddenDefinition(isHidden: false)
    }

    private func setHiddenDefinition(isHidden: Bool) {
        definitionNode.isHidden = isHidden
        definitionView.isHidden = isHidden
    }

    private func drawDefinitionView(
        definitionConfiguration: ChartDefinition,
        linePositionX: CGFloat,
        maxDefinitionLabelWidth: CGFloat
    ) {
        let valueLabelHeight = definitionConfiguration.view.valueLabelFont.lineHeight.rounded(.up)
        let chartCount = CGFloat(chartsConfiguration.count)
        let definitionViewRect = makeDefinitionViewRect(
            chartRect: chartFrame,
            linePositionX: linePositionX,
            maxDefinitionLabelWidth: maxDefinitionLabelWidth,
            valueLabelHeight: valueLabelHeight,
            dateLabelHeight: definitionConfiguration.view.dateLabelFont.lineHeight.rounded(.up),
            chartCount: chartCount
        )

        if definitionView.position == .zero {
            definitionView.path = CGPath(
                roundedRect: .init(
                    origin: .zero,
                    size: definitionViewRect.size
                ),
                cornerWidth: 6,
                cornerHeight: 6,
                transform: nil
            )
            definitionView.position = definitionViewRect.origin
        } else if definitionView.position.x.rounded() != definitionViewRect.origin.x.rounded()
               || definitionView.path?.boundingBox.size ?? .zero != definitionViewRect.size {
            definitionView.path = CGPath(
                roundedRect: .init(
                    origin: .zero,
                    size: definitionViewRect.size
                ),
                cornerWidth: 6,
                cornerHeight: 6,
                transform: nil
            )
            let moveAction = SKAction.move(
                to: definitionViewRect.origin,
                duration: 0.1
            )
            definitionView.run(
                moveAction
            )
        }

        definitionChartLines.enumerated().forEach {
            let y = definitionViewRect.height - 12 - (CGFloat($0.offset) + 0.5) * valueLabelHeight
            $0.element.position = .init(
                x: 12,
                y: y
            )
        }

        definitionValueLabels.enumerated().forEach {
            let y = definitionViewRect.height - 12 - CGFloat($0.offset) * valueLabelHeight
            $0.element.position = .init(
                x: 34,
                y: y
            )
        }

        let y = definitionViewRect.height - 14 - chartCount * valueLabelHeight
        definitionDateLabel.position = .init(
            x: 34,
            y: y
        )
    }
}

// MARK: - Make frames and positions for nodes
private extension RenderSpriteKitImpl {
    private func makeRangeLabelPosition(
        size: CGSize
    ) -> CGPoint {
        let rangeLabelInsetTop = configuration.rangeLabel?.insets.top ?? 0
        let rangeLabelX = size.width / 2
        let rangeLabelY = size.height
            - rangeLabelInsetTop
        return CGPoint(
            x: rangeLabelX,
            y: rangeLabelY
        )
    }

    private func makeXAxisFrame(
        size: CGSize
    ) -> CGRect {
        let xAxisInsetBottom = configuration.xAxis?.insets.bottom ?? 0
        let xAxisLabelsHeight = configuration.xAxis?.labelFont.lineHeight.rounded(.up) ?? 0
        let xAxisY = xAxisInsetBottom
        let xAxisWidth = size.width
        return CGRect(
            x: 0,
            y: xAxisY,
            width: xAxisWidth,
            height: xAxisLabelsHeight
        )
    }

    private func makeGradientFrame(
        size: CGSize,
        xAxisFrame: CGRect
    ) -> CGRect {
        let xAxisInsetTop = configuration.xAxis?.insets.top ?? 0
        let chartInsets = configuration.chartInsets
        let gradientY = xAxisFrame.maxY
            + xAxisInsetTop
            + chartInsets.bottom
        let gradientWidth = size.width
        let gradientHeight = size.height
            - gradientY
        return CGRect(
            x: 0,
            y: gradientY,
            width: gradientWidth,
            height: gradientHeight
        )
    }

    private func makeChartFrame(
        size: CGSize,
        xAxisFrame: CGRect,
        rangeLabelPositionY: CGFloat
    ) -> CGRect {
        let rangeLabelHeight = configuration.rangeLabel?.font.lineHeight.rounded(.up) ?? 0
        let rangeLabelInsetBottom = configuration.rangeLabel?.insets.bottom ?? 0
        let xAxisInsetTop = configuration.xAxis?.insets.top ?? 0
        let chartInsets = configuration.chartInsets
        let chartY = xAxisFrame.maxY
            + xAxisInsetTop
            + chartInsets.bottom
        let chartWidth = size.width
        let chartHeight = rangeLabelPositionY
            - rangeLabelHeight
            - rangeLabelInsetBottom
            - chartInsets.top
            - chartY
        return CGRect(
            x: 0,
            y: chartY,
            width: chartWidth,
            height: chartHeight
        )
    }

    private func makeDefinitionViewRect(
        chartRect: CGRect,
        linePositionX: CGFloat,
        maxDefinitionLabelWidth: CGFloat,
        valueLabelHeight: CGFloat,
        dateLabelHeight: CGFloat,
        chartCount: CGFloat
    ) -> CGRect {
        let width = maxDefinitionLabelWidth + 48
        let height = valueLabelHeight * chartCount
            + dateLabelHeight
            + 22

        let x: CGFloat

        if linePositionX + 10 + width > chartRect.maxX {
            x = linePositionX - 10 - width
        } else {
            x = linePositionX + 10
        }

        return CGRect(
            x: x,
            y: chartRect.maxY - height,
            width: width,
            height: height
        )
    }
}
