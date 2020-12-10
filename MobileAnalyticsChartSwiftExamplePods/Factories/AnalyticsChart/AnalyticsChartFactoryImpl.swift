import MobileAnalyticsChartSwift
import UIKit

final class AnalyticsChartFactoryImpl {

    // MARK: - Formatters

    private lazy var shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter
    }()

    private lazy var longDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
}

// MARK: - AnalyticsChartFactory

extension AnalyticsChartFactoryImpl: AnalyticsChartFactory {
    func makeViewModels() -> [AnalyticsChartViewModel] {
        return [
            makeSimpleChart(),
            makeChartWithOnlyOnePoint(),
            makeChartWithTwoPoints(),
            makeMultipleCharts(),
            makeOnlyChart(),
            makeChartWithAnimations(),
            makeMultiselectCharts(),
            makeSimpleChartWithDefaultStaticValue(),
            makeSimpleChartWithCustomStaticValue(),
            makeSimpleChartWithBoundaryStaticValue(),
            makeSimpleChartWithoutGradient(),
            makeSimpleChartWithoutGestures(),
        ]
    }

    private func makeSimpleChart() -> AnalyticsChartViewModel {
        return AnalyticsChartViewModel(
            title: "Simple Chart",
            type: .default,
            data: AnalyticsChartSpriteKitModuleInputData(
                viewModels: [
                    makeSimpleData(
                        color: .radicalRed,
                        count: 100,
                        valuesRange: -100 ..< 100
                    ),
                ],
                renderConfiguration: RenderConfiguration(
                    rangeLabel: makeRangeLabelConfiguration(dateFormatter: longDateFormatter),
                    xAxis: makeXAxis(dateFormatter: shortDateFormatter),
                    yAxis: makeYAxis(),
                    zeroLine: makeZeroLine(),
                    gestureState: makeGestureState(),
                    animation: makeAnimation(),
                    definition: makeChartDefinition(),
                    backgroundColor: Constants.Render.backgroundColor,
                    chartInsets: Constants.Render.chartInsets,
                    chartMargins: Constants.Render.chartMargins,
                    fadeInDuration: Constants.Render.fadeInDuration,
                    fadeOutDuration: Constants.Render.fadeOutDuration
                ),
                calculatorConfiguration: CalculatorConfiguration(
                    minStaticValue: nil,
                    maxStaticValue: nil
                )
            )
        )
    }

    private func makeChartWithOnlyOnePoint() -> AnalyticsChartViewModel {
        return AnalyticsChartViewModel(
            title: "Chart with only one point",
            type: .default,
            data: AnalyticsChartSpriteKitModuleInputData(
                viewModels: [
                    makeSimpleData(
                        color: .radicalRed,
                        count: 1,
                        valuesRange: -100 ..< 100
                    ),
                ],
                renderConfiguration: RenderConfiguration(
                    rangeLabel: makeRangeLabelConfiguration(dateFormatter: longDateFormatter),
                    xAxis: makeXAxis(dateFormatter: shortDateFormatter),
                    yAxis: makeYAxis(),
                    zeroLine: makeZeroLine(),
                    gestureState: makeGestureState(),
                    animation: makeAnimation(),
                    definition: makeChartDefinition(),
                    backgroundColor: Constants.Render.backgroundColor,
                    chartInsets: Constants.Render.chartInsets,
                    chartMargins: Constants.Render.chartMargins,
                    fadeInDuration: Constants.Render.fadeInDuration,
                    fadeOutDuration: Constants.Render.fadeOutDuration
                ),
                calculatorConfiguration: CalculatorConfiguration(
                    minStaticValue: nil,
                    maxStaticValue: nil
                )
            )
        )
    }

    private func makeChartWithTwoPoints() -> AnalyticsChartViewModel {
        return AnalyticsChartViewModel(
            title: "Chart with two points",
            type: .default,
            data: AnalyticsChartSpriteKitModuleInputData(
                viewModels: [
                    makeSimpleData(
                        color: .radicalRed,
                        count: 2,
                        valuesRange: -100 ..< 100
                    ),
                ],
                renderConfiguration: RenderConfiguration(
                    rangeLabel: makeRangeLabelConfiguration(dateFormatter: longDateFormatter),
                    xAxis: makeXAxis(dateFormatter: shortDateFormatter),
                    yAxis: makeYAxis(),
                    zeroLine: makeZeroLine(),
                    gestureState: makeGestureState(),
                    animation: makeAnimation(),
                    definition: makeChartDefinition(),
                    backgroundColor: Constants.Render.backgroundColor,
                    chartInsets: Constants.Render.chartInsets,
                    chartMargins: Constants.Render.chartMargins,
                    fadeInDuration: Constants.Render.fadeInDuration,
                    fadeOutDuration: Constants.Render.fadeOutDuration
                ),
                calculatorConfiguration: CalculatorConfiguration(
                    minStaticValue: nil,
                    maxStaticValue: nil
                )
            )
        )
    }

    private func makeMultipleCharts() -> AnalyticsChartViewModel {
        return AnalyticsChartViewModel(
            title: "Multiple Charts",
            type: .default,
            data: AnalyticsChartSpriteKitModuleInputData(
                viewModels: [
                    makeSimpleData(
                        color: .radicalRed,
                        count: 100,
                        valuesRange: -100 ..< 100
                    ),
                    makeSimpleData(
                        color: .dodgerBlue,
                        count: 100,
                        valuesRange: -100 ..< 100
                    ),
                    makeSimpleData(
                        color: .heliotrope,
                        count: 100,
                        valuesRange: -100 ..< 100
                    ),
                    makeSimpleData(
                        color: .baliHai,
                        count: 100,
                        valuesRange: -100 ..< 100
                    ),
                ],
                renderConfiguration: RenderConfiguration(
                    rangeLabel: makeRangeLabelConfiguration(dateFormatter: longDateFormatter),
                    xAxis: makeXAxis(dateFormatter: shortDateFormatter),
                    yAxis: makeYAxis(),
                    zeroLine: makeZeroLine(),
                    gestureState: makeGestureState(),
                    animation: makeAnimation(),
                    definition: makeChartDefinition(),
                    backgroundColor: Constants.Render.backgroundColor,
                    chartInsets: Constants.Render.chartInsets,
                    chartMargins: Constants.Render.chartMargins,
                    fadeInDuration: Constants.Render.fadeInDuration,
                    fadeOutDuration: Constants.Render.fadeOutDuration
                ),
                calculatorConfiguration: CalculatorConfiguration(
                    minStaticValue: nil,
                    maxStaticValue: nil
                )
            )
        )
    }

    private func makeOnlyChart() -> AnalyticsChartViewModel {
        return AnalyticsChartViewModel(
            title: "Only chart",
            type: .default,
            data: AnalyticsChartSpriteKitModuleInputData(
                viewModels: [
                    makeSimpleData(
                        color: .radicalRed,
                        withGradient: false,
                        count: 100,
                        valuesRange: -100 ..< 100
                    ),
                ],
                renderConfiguration: RenderConfiguration(
                    rangeLabel: nil,
                    xAxis: nil,
                    yAxis: nil,
                    zeroLine: nil,
                    gestureState: ChartGestureState(
                        swipeIsActive: false,
                        pinchIsActive: false,
                        handleIsActive: false
                    ),
                    animation: makeAnimation(),
                    definition: nil,
                    backgroundColor: Constants.Render.backgroundColor,
                    chartInsets: .zero,
                    chartMargins: .zero,
                    fadeInDuration: Constants.Render.fadeInDuration,
                    fadeOutDuration: Constants.Render.fadeOutDuration
                ),
                calculatorConfiguration: CalculatorConfiguration(
                    minStaticValue: nil,
                    maxStaticValue: nil
                )
            )
        )
    }

    private func makeSimpleChartWithDefaultStaticValue() -> AnalyticsChartViewModel {
        return AnalyticsChartViewModel(
            title: "Simple Chart with default static values",
            type: .default,
            data: AnalyticsChartSpriteKitModuleInputData(
                viewModels: [
                    makeSimpleData(
                        color: .radicalRed,
                        count: 1000,
                        valuesRange: -1000 ..< 1000
                    ),
                ],
                renderConfiguration: RenderConfiguration(
                    rangeLabel: makeRangeLabelConfiguration(dateFormatter: longDateFormatter),
                    xAxis: makeXAxis(dateFormatter: shortDateFormatter),
                    yAxis: makeYAxis(),
                    zeroLine: makeZeroLine(),
                    gestureState: makeGestureState(),
                    animation: makeAnimation(),
                    definition: makeChartDefinition(),
                    backgroundColor: Constants.Render.backgroundColor,
                    chartInsets: Constants.Render.chartInsets,
                    chartMargins: Constants.Render.chartMargins,
                    fadeInDuration: Constants.Render.fadeInDuration,
                    fadeOutDuration: Constants.Render.fadeOutDuration
                ),
                calculatorConfiguration: CalculatorConfiguration(
                    minStaticValue: .default,
                    maxStaticValue: .default
                )
            )
        )
    }

    private func makeSimpleChartWithCustomStaticValue() -> AnalyticsChartViewModel {
        return AnalyticsChartViewModel(
            title: "Simple Chart with custom static values",
            type: .default,
            data: AnalyticsChartSpriteKitModuleInputData(
                viewModels: [
                    makeSimpleData(
                        color: .radicalRed,
                        count: 1000,
                        valuesRange: 50 ..< 150
                    ),
                ],
                renderConfiguration: RenderConfiguration(
                    rangeLabel: makeRangeLabelConfiguration(dateFormatter: longDateFormatter),
                    xAxis: makeXAxis(dateFormatter: shortDateFormatter),
                    yAxis: makeYAxis(),
                    zeroLine: makeZeroLine(),
                    gestureState: makeGestureState(),
                    animation: makeAnimation(),
                    definition: makeChartDefinition(),
                    backgroundColor: Constants.Render.backgroundColor,
                    chartInsets: Constants.Render.chartInsets,
                    chartMargins: Constants.Render.chartMargins,
                    fadeInDuration: Constants.Render.fadeInDuration,
                    fadeOutDuration: Constants.Render.fadeOutDuration
                ),
                calculatorConfiguration: CalculatorConfiguration(
                    minStaticValue: .customValue(0),
                    maxStaticValue: .customValue(200)
                )
            )
        )
    }

    private func makeSimpleChartWithBoundaryStaticValue() -> AnalyticsChartViewModel {
        return AnalyticsChartViewModel(
            title: "Simple Chart with boundary static values",
            type: .default,
            data: AnalyticsChartSpriteKitModuleInputData(
                viewModels: [
                    makeSimpleData(
                        color: .radicalRed,
                        count: 100,
                        valuesRange: 0 ..< 3
                    ),
                ],
                renderConfiguration: RenderConfiguration(
                    rangeLabel: makeRangeLabelConfiguration(dateFormatter: longDateFormatter),
                    xAxis: makeXAxis(dateFormatter: shortDateFormatter),
                    yAxis: makeYAxis(),
                    zeroLine: makeZeroLine(),
                    gestureState: makeGestureState(),
                    animation: makeAnimation(),
                    definition: makeChartDefinition(),
                    backgroundColor: Constants.Render.backgroundColor,
                    chartInsets: Constants.Render.chartInsets,
                    chartMargins: Constants.Render.chartMargins,
                    fadeInDuration: Constants.Render.fadeInDuration,
                    fadeOutDuration: Constants.Render.fadeOutDuration
                ),
                calculatorConfiguration: CalculatorConfiguration(
                    minStaticValue: .boundaryValue(0),
                    maxStaticValue: .boundaryValue(1)
                )
            )
        )
    }

    private func makeSimpleChartWithoutGradient() -> AnalyticsChartViewModel {
        return AnalyticsChartViewModel(
            title: "Simple Chart without gradient",
            type: .default,
            data: AnalyticsChartSpriteKitModuleInputData(
                viewModels: [
                    makeSimpleData(
                        color: .radicalRed,
                        withGradient: false,
                        count: 100,
                        valuesRange: -100 ..< 100
                    ),
                ],
                renderConfiguration: RenderConfiguration(
                    rangeLabel: makeRangeLabelConfiguration(dateFormatter: longDateFormatter),
                    xAxis: makeXAxis(dateFormatter: shortDateFormatter),
                    yAxis: makeYAxis(),
                    zeroLine: makeZeroLine(),
                    gestureState: makeGestureState(),
                    animation: makeAnimation(),
                    definition: makeChartDefinition(),
                    backgroundColor: Constants.Render.backgroundColor,
                    chartInsets: Constants.Render.chartInsets,
                    chartMargins: Constants.Render.chartMargins,
                    fadeInDuration: Constants.Render.fadeInDuration,
                    fadeOutDuration: Constants.Render.fadeOutDuration
                ),
                calculatorConfiguration: CalculatorConfiguration(
                    minStaticValue: nil,
                    maxStaticValue: nil
                )
            )
        )
    }

    private func makeSimpleChartWithoutGestures() -> AnalyticsChartViewModel {
        return AnalyticsChartViewModel(
            title: "Simple Chart without gestures",
            type: .default,
            data: AnalyticsChartSpriteKitModuleInputData(
                viewModels: [
                    makeSimpleData(
                        color: .radicalRed,
                        count: 100,
                        valuesRange: -100 ..< 100
                    ),
                ],
                renderConfiguration: RenderConfiguration(
                    rangeLabel: makeRangeLabelConfiguration(dateFormatter: longDateFormatter),
                    xAxis: makeXAxis(dateFormatter: shortDateFormatter),
                    yAxis: makeYAxis(),
                    zeroLine: makeZeroLine(),
                    gestureState: ChartGestureState(
                        swipeIsActive: false,
                        pinchIsActive: false,
                        handleIsActive: false
                    ),
                    animation: makeAnimation(),
                    definition: makeChartDefinition(),
                    backgroundColor: Constants.Render.backgroundColor,
                    chartInsets: Constants.Render.chartInsets,
                    chartMargins: Constants.Render.chartMargins,
                    fadeInDuration: Constants.Render.fadeInDuration,
                    fadeOutDuration: Constants.Render.fadeOutDuration
                ),
                calculatorConfiguration: CalculatorConfiguration(
                    minStaticValue: nil,
                    maxStaticValue: nil
                )
            )
        )
    }

    private func makeChartWithAnimations() -> AnalyticsChartViewModel {
        return AnalyticsChartViewModel(
            title: "Chart with animations",
            type: .custom,
            data: AnalyticsChartSpriteKitModuleInputData(
                viewModels: [
                    makeSimpleData(
                        color: .radicalRed,
                        count: 20,
                        valuesRange: -100 ..< 100
                    ),
                    makeSimpleData(
                        color: .dodgerBlue,
                        count: 20,
                        valuesRange: -100 ..< 100
                    ),
                ],
                renderConfiguration: RenderConfiguration(
                    rangeLabel: makeRangeLabelConfiguration(dateFormatter: longDateFormatter),
                    xAxis: makeXAxis(dateFormatter: shortDateFormatter),
                    yAxis: makeYAxis(),
                    zeroLine: makeZeroLine(),
                    gestureState: makeGestureState(),
                    animation: makeAnimation(),
                    definition: makeChartDefinition(),
                    backgroundColor: Constants.Render.backgroundColor,
                    chartInsets: Constants.Render.chartInsets,
                    chartMargins: Constants.Render.chartMargins,
                    fadeInDuration: Constants.Render.fadeInDuration,
                    fadeOutDuration: Constants.Render.fadeOutDuration
                ),
                calculatorConfiguration: CalculatorConfiguration(
                    minStaticValue: nil,
                    maxStaticValue: nil
                )
            )
        )
    }

    private func makeMultiselectCharts() -> AnalyticsChartViewModel {
        return AnalyticsChartViewModel(
            title: "Multiselect Charts",
            type: .multiselect,
            data: AnalyticsChartSpriteKitModuleInputData(
                viewModels: [
                    makeSimpleData(
                        color: .radicalRed,
                        withGradient: false,
                        count: 20,
                        valuesRange: -100 ..< 100
                    ),
                    makeSimpleData(
                        color: .dodgerBlue,
                        withGradient: false,
                        count: 20,
                        valuesRange: -100 ..< 100
                    ),
                    makeSimpleData(
                        color: .heliotrope,
                        withGradient: false,
                        count: 20,
                        valuesRange: -100 ..< 100
                    ),
                    makeSimpleData(
                        color: .baliHai,
                        withGradient: false,
                        count: 20,
                        valuesRange: -100 ..< 100
                    ),
                ],
                renderConfiguration: RenderConfiguration(
                    rangeLabel: makeRangeLabelConfiguration(dateFormatter: longDateFormatter),
                    xAxis: makeXAxis(dateFormatter: shortDateFormatter),
                    yAxis: makeYAxis(),
                    zeroLine: makeZeroLine(),
                    gestureState: makeGestureState(),
                    animation: makeAnimation(),
                    definition: makeChartDefinition(),
                    backgroundColor: Constants.Render.backgroundColor,
                    chartInsets: Constants.Render.chartInsets,
                    chartMargins: Constants.Render.chartMargins,
                    fadeInDuration: Constants.Render.fadeInDuration,
                    fadeOutDuration: Constants.Render.fadeOutDuration
                ),
                calculatorConfiguration: CalculatorConfiguration(
                    minStaticValue: nil,
                    maxStaticValue: nil
                )
            )
        )
    }

    private func makeSimpleData(
        color: UIColor,
        withGradient: Bool = true,
        count: Int,
        valuesRange: Range<CGFloat>
    ) -> AnalyticsChartSpriteKitViewModel {
        let calendar = Calendar.current
        let dates = (0 ..< count).compactMap {
            calendar.date(byAdding: DateComponents(day: $0), to: Date())
        }

        let data = ChartData(
            values: (0 ..< count).map { _ in CGFloat.random(in: valuesRange) },
            dates: dates
        )

        return AnalyticsChartSpriteKitViewModel(
            data: data,
            configuration: ChartRenderConfiguration(
                unit: .quantity,
                path: makeChartPath(pathColor: color),
                gradient: withGradient
                    ? makeGradient(color: color)
                    : nil
            )
        )
    }
}

// MARK: - ChartRenderConfiguration

extension AnalyticsChartFactoryImpl {
    private func makeChartPath(
        pathColor: UIColor
    ) -> ChartPath {
        return ChartPath(
            type: Constants.Path.type,
            color: pathColor,
            minWidth: Constants.Path.minWidth,
            maxWidth: Constants.Path.maxWidth,
            fadeAnimation: makePathFadeAnimation()
        )
    }

    private func makePathFadeAnimation() -> ChartFadeAnimation {
        return ChartFadeAnimation(
            fadeOutColor: Constants.Path.FadeAnimation.fadeOutColor,
            fadeInColor: Constants.Path.FadeAnimation.fadeInColor,
            startDuration: Constants.Path.FadeAnimation.startDuration,
            fadeOutDuration: Constants.Path.FadeAnimation.fadeOutDuration,
            fadeInDuration: Constants.Path.FadeAnimation.fadeInDuration
        )
    }

    private func makeGradient(
        color: UIColor?
    ) -> Gradient? {
        guard let color = color else { return nil }

        return Gradient(
            firstColor: color.withAlphaComponent(Constants.Gradient.firstColorAlpha),
            secondColor: color.withAlphaComponent(Constants.Gradient.secondColorAlpha),
            fadeAnimation: makeGradientFadeAnimation()
        )
    }

    private func makeGradientFadeAnimation() -> ChartFadeAnimation {
        return ChartFadeAnimation(
            fadeOutColor: Constants.Gradient.FadeAnimation.fadeOutColor,
            fadeInColor: Constants.Gradient.FadeAnimation.fadeInColor,
            startDuration: Constants.Gradient.FadeAnimation.startDuration,
            fadeOutDuration: Constants.Gradient.FadeAnimation.fadeOutDuration,
            fadeInDuration: Constants.Gradient.FadeAnimation.fadeInDuration
        )
    }

    private func makeChartDefinition() -> ChartDefinition {
        return ChartDefinition(
            line: makeChartDefinitionLine(),
            point: makeChartDefinitionPoint(),
            view: makeChartDefinitionView(),
            fadeAnimation: makeDefinitionFadeAnimation()
        )
    }

    private func makeChartDefinitionLine() -> ChartDefinitionLine {
        return ChartDefinitionLine(
            color: Constants.Definition.Line.color,
            width: Constants.Definition.Line.width
        )
    }

    private func makeChartDefinitionPoint() -> ChartDefinitionPoint {
        return ChartDefinitionPoint(
            minRadius: Constants.Definition.Line.minPointRadius,
            maxRadius: Constants.Definition.Line.maxPointRadius
        )
    }

    private func makeChartDefinitionView() -> ChartDefinitionView {
        return ChartDefinitionView(
            backgroundColor: Constants.Definition.View.backgroundColor,
            valueLabelFont: Constants.Definition.ValueLabel.font,
            valueLabelColor: Constants.Definition.ValueLabel.color,
            dateLabelFont: Constants.Definition.DateLabel.font,
            dateLabelColor: Constants.Definition.DateLabel.color,
            dateFormatter: longDateFormatter
        )
    }

    private func makeDefinitionFadeAnimation() -> ChartFadeAnimation {
        return ChartFadeAnimation(
            fadeOutColor: Constants.Path.FadeAnimation.fadeOutColor,
            fadeInColor: Constants.Path.FadeAnimation.fadeInColor,
            startDuration: Constants.Path.FadeAnimation.startDuration,
            fadeOutDuration: Constants.Path.FadeAnimation.fadeOutDuration,
            fadeInDuration: Constants.Path.FadeAnimation.fadeInDuration
        )
    }
}

// MARK: - RenderConfiguration

extension AnalyticsChartFactoryImpl {
    private func makeRangeLabelConfiguration(
        dateFormatter: DateFormatter
    ) -> ChartRangeLabel {
        return ChartRangeLabel(
            color: Constants.RangeLabel.color,
            font: Constants.RangeLabel.font,
            dateFormatter: dateFormatter,
            insets: Constants.RangeLabel.insets
        )
    }

    private func makeXAxis(
        dateFormatter: DateFormatter
    ) -> ChartXAxis {
        return ChartXAxis(
            labelColor: Constants.XAxis.Label.color,
            labelFont: Constants.XAxis.Label.font,
            dateFormatter: dateFormatter,
            insets: Constants.XAxis.insets,
            margins: Constants.XAxis.margins,
            zoomFactorLabels: Constants.XAxis.Label.zoomFactor
        )
    }

    private func makeYAxis() -> ChartYAxis {
        return ChartYAxis(
            labelColor: Constants.YAxis.Label.color,
            labelFont: Constants.YAxis.Label.font,
            labelInsets: Constants.YAxis.Label.insets,
            lineColor: Constants.YAxis.Line.color,
            lineWidth: Constants.YAxis.Line.width
        )
    }

    private func makeZeroLine() -> ChartZeroLine {
        return ChartZeroLine(
            color: Constants.ZeroLine.color,
            width: Constants.ZeroLine.width
        )
    }

    private func makeGestureState() -> ChartGestureState {
        return ChartGestureState(
            swipeIsActive: Constants.Gesture.swipeIsActive,
            pinchIsActive: Constants.Gesture.pinchIsActive,
            handleIsActive: Constants.Gesture.handleIsActive
        )
    }

    private func makeAnimation() -> ChartAnimation {
        return ChartAnimation(
            redrawDuration: 0.2
        )
    }
}

// MARK: - Constants

private extension AnalyticsChartFactoryImpl {
    enum Constants {
        enum Render {
            static let backgroundColor: UIColor = .cararra
            static let chartInsets: UIEdgeInsets = .zero
            static let chartMargins: UIEdgeInsets = .init(
                top: Space.quadruple * 2,
                left: 0,
                bottom: 0,
                right: 0
            )
            static let fadeInDuration: TimeInterval = 0.3
            static let fadeOutDuration: TimeInterval = 0.3
        }
        enum Path {
            static let type: ChartPathType = .horizontalQuadratic
            static let minWidth: CGFloat = 1.0
            static let maxWidth: CGFloat = 5.0
            enum FadeAnimation {
                static let fadeOutColor: UIColor = .alto
                static let fadeInColor: UIColor = .gallery
                static let startDuration: TimeInterval = 0.2
                static let fadeOutDuration: TimeInterval = 0.6
                static let fadeInDuration: TimeInterval = 0.6
            }
        }
        enum Gradient {
            static let firstColorAlpha: CGFloat = 0.0
            static let secondColorAlpha: CGFloat = 0.3
            enum FadeAnimation {
                static let fadeOutColor = UIColor(red: 163 / 255, green: 163 / 255, blue: 163 / 255, alpha: 0.105)
                static let fadeInColor = UIColor(red: 163 / 255, green: 163 / 255, blue: 163 / 255, alpha: 0.03)
                static let startDuration: TimeInterval = 0.2
                static let fadeOutDuration: TimeInterval = 0.6
                static let fadeInDuration: TimeInterval = 0.6
            }
        }
        enum RangeLabel {
            static let color: UIColor = .doveGray
            static let font: UIFont = .dynamicCaption1
            static let insets: UIEdgeInsets = .init(
                top: Space.double,
                left: 0,
                bottom: Space.double,
                right: 0
            )
        }
        enum Definition {
            enum Line {
                static let color: UIColor = .gallery
                static let width: CGFloat = 1.0
                static let minPointRadius: CGFloat = Space.single / 2
                static let maxPointRadius: CGFloat = Space.single
            }
            enum ValueLabel {
                static let color = UIColor(white: 0.95, alpha: 1.0)
                static let font: UIFont = .systemFont(ofSize: 13)
            }
            enum DateLabel {
                static let color = UIColor(white: 0.7, alpha: 1.0)
                static let font: UIFont = .systemFont(ofSize: 11)
            }
            enum View {
                static let backgroundColor = UIColor(red: 0.043, green: 0.09, blue: 0.204, alpha: 1)
            }
        }
        enum XAxis {
            static let insets: UIEdgeInsets = .init(
                top: Space.single,
                left: 0,
                bottom: 0,
                right: 0
            )
            static let margins: UIEdgeInsets = .init(
                top: 0,
                left: Space.double,
                bottom: 0,
                right: Space.double
            )
            enum Label {
                static let color: UIColor = .ghost
                static let font: UIFont = .dynamicCaption2
                static let zoomFactor: CGFloat = 1.5
            }
        }
        enum YAxis {
            enum Label {
                static let color: UIColor = .ghost
                static let font: UIFont = .dynamicCaption2
                static let insets: UIEdgeInsets = .init(
                    top: Space.single,
                    left: Space.double,
                    bottom: Space.single,
                    right: 0
                )
            }
            enum Line {
                static let color: UIColor = .border
                static let width: CGFloat = 1.0
            }
        }
        enum ZeroLine {
            static let color: UIColor = .borderZeroLine
            static let width: CGFloat = 2.0
        }
        enum Gesture {
            static let swipeIsActive: Bool = true
            static let pinchIsActive: Bool = true
            static let handleIsActive: Bool = true
        }
    }
}
