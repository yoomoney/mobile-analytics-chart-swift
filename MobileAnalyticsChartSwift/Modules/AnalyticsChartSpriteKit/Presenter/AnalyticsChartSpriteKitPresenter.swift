import UIKit

/// VIPER Presenter of AnalyticsChartSpriteKit module.
final public class AnalyticsChartSpriteKitPresenter {

    // MARK: - VIPER

    weak var view: AnalyticsChartSpriteKitViewInput?
    weak var moduleOutput: AnalyticsChartSpriteKitModuleOutput?

    // MARK: - Init data

    private var viewModels: [AnalyticsChartSpriteKitViewModel]
    private var renderConfiguration: RenderConfiguration
    private var calculatorConfiguration: CalculatorConfiguration
    private let analyticsYAxisLocalizationFactory: AnalyticsYAxisLocalizationFactory
    private let analyticsDefinitionFactory: AnalyticsDefinitionFactory

    /// Creates instance of `AnalyticsChartSpriteKitPresenter`.
    ///
    /// - Parameters:
    ///     - viewModels: ViewModels of AnalyticsChartSpriteKitViewModel.
    ///     - renderConfiguration: Entity of RenderConfiguration.
    ///     - calculatorConfiguration: Entity of CalculatorConfiguration.
    ///     - analyticsYAxisLocalizationFactory: Entity of AnalyticsYAxisLocalizationFactory.
    ///     - analyticsDefinitionFactory: Entity of AnalyticsDefinitionFactory.
    ///
    /// - Returns: Instance of `AnalyticsChartSpriteKitPresenter`.
    public init(
        viewModels: [AnalyticsChartSpriteKitViewModel],
        renderConfiguration: RenderConfiguration,
        calculatorConfiguration: CalculatorConfiguration,
        analyticsYAxisLocalizationFactory: AnalyticsYAxisLocalizationFactory,
        analyticsDefinitionFactory: AnalyticsDefinitionFactory
    ) {
        self.viewModels = viewModels
        self.renderConfiguration = renderConfiguration
        self.calculatorConfiguration = calculatorConfiguration
        self.analyticsYAxisLocalizationFactory = analyticsYAxisLocalizationFactory
        self.analyticsDefinitionFactory = analyticsDefinitionFactory
    }

    // MARK: - Module input

    private weak var renderDrawerModuleInput: RenderDrawerModuleInput?

    // MARK: - Stored data

    private var scene: RenderSpriteKitImpl?
    private var rangeValue: RangeValue<CGFloat>?
}

// MARK: - AnalyticsChartSpriteKitViewOutput

extension AnalyticsChartSpriteKitPresenter: AnalyticsChartSpriteKitViewOutput {
    func setupView() {
        guard let view = view else { return }

        let scene = makeScene(
            viewModels: viewModels
        )
        self.scene = scene
        renderDrawerModuleInput = scene
        view.setScene(scene: scene)
    }

    func redraw() {
        guard let view = view,
              let scene = scene else { return }

        view.setScene(scene: scene)
    }

    func traitCollectionDidChange() {
        renderDrawerModuleInput?.setConfiguration(renderConfiguration)
    }

    private func makeScene(
        viewModels: [AnalyticsChartSpriteKitViewModel]
    ) -> RenderSpriteKitImpl {
        let calculator = CalculatorImpl(
            data: viewModels.map { $0.data },
            configuration: calculatorConfiguration
        )

        let renderSpriteKitImpl = RenderSpriteKitImpl(
            chartsConfiguration: viewModels.map { $0.configuration },
            configuration: renderConfiguration,
            calculator: calculator,
            analyticsYAxisLocalizationFactory: analyticsYAxisLocalizationFactory,
            analyticsDefinitionFactory: analyticsDefinitionFactory
        )
        renderSpriteKitImpl.moduleOutput = self
        return renderSpriteKitImpl
    }
}

// MARK: - RenderDrawerModuleOutput

extension AnalyticsChartSpriteKitPresenter: RenderDrawerModuleOutput {
    public func didChangeRangeValue(
        rangeValue: RangeValue<CGFloat>
    ) {
        self.rangeValue = rangeValue
        moduleOutput?.didChangeRangeValue(rangeValue: rangeValue)
    }

    public func didHandleLongPress() {
        moduleOutput?.didHandleLongPress()
    }

    public func didHandlePan(
        deltaLocation: CGFloat
    ) {
        moduleOutput?.didHandlePan(deltaLocation: deltaLocation)
    }

    public func didHandlePinch(
        scale: CGFloat
    ) {
        moduleOutput?.didHandlePinch(scale: scale)
    }
}

// MARK: - AnalyticsChartSpriteKitModuleInput

extension AnalyticsChartSpriteKitPresenter: AnalyticsChartSpriteKitModuleInput {
    public func setChartViewModels(
        viewModels: [AnalyticsChartSpriteKitViewModel],
        silent: Bool
    ) {
        self.viewModels = viewModels

        guard !viewModels.isEmpty else {
            let calculator = makeCalculator(data: viewModels.map { $0.data })
            renderDrawerModuleInput?.setCalculator(calculator)
            return
        }

        renderDrawerModuleInput?.stopFade()
        renderDrawerModuleInput?.fadeOutChart()

        renderDrawerModuleInput?.setChartsConfiguration(
            viewModels.map { $0.configuration }
        )

        renderDrawerModuleInput?.fadeInChart()

        if silent {
            let calculator = CalculatorImpl(
                data: viewModels.map { $0.data },
                configuration: CalculatorConfiguration(
                    minStaticValue: calculatorConfiguration.minStaticValue,
                    maxStaticValue: calculatorConfiguration.maxStaticValue,
                    initialLowerValue: rangeValue?.lowerValue ?? 0.0,
                    initialUpperValue: rangeValue?.upperValue ?? 1.0
                )
            )
            renderDrawerModuleInput?.setCalculator(calculator)
        } else {
            let calculator = makeCalculator(data: viewModels.map { $0.data })
            renderDrawerModuleInput?.setCalculator(calculator)
        }
    }

    public func setChartLoadingState() {
        renderDrawerModuleInput?.startFade()
    }

    public func setChartIdleState() {
        renderDrawerModuleInput?.stopFade()
    }

    public func setRangeValue(
        rangeValue: RangeValue<CGFloat>
    ) {
        self.rangeValue = rangeValue
    }

    private func makeCalculator(
        data: [ChartData]
    ) -> Calculator {
        return CalculatorImpl(
            data: data,
            configuration: calculatorConfiguration
        )
    }
}
