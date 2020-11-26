import CoreGraphics

/// AnalyticsChartSpriteKit module inputData.
public struct AnalyticsChartSpriteKitModuleInputData {

    /// ViewModels of AnalyticsChartSpriteKitViewModel.
    public let viewModels: [AnalyticsChartSpriteKitViewModel]

    /// Entity of RenderConfiguration.
    public let renderConfiguration: RenderConfiguration

    /// Entity of CalculatorConfiguration.
    public let calculatorConfiguration: CalculatorConfiguration

    /// Accessibility identifier.
    public let accessibilityIdentifier: String?

    /// Creates instance of `AnalyticsChartSpriteKitModuleInputData`.
    ///
    /// - Parameters:
    ///     - viewModels: ViewModels of AnalyticsChartSpriteKitViewModel.
    ///     - renderConfiguration: Entity of RenderConfiguration.
    ///     - calculatorConfiguration: Entity of CalculatorConfiguration.
    ///     - accessibilityIdentifier: Accessibility identifier.
    ///
    /// - Returns: Instance of `AnalyticsChartSpriteKitModuleInputData`.
    public init(
        viewModels: [AnalyticsChartSpriteKitViewModel],
        renderConfiguration: RenderConfiguration,
        calculatorConfiguration: CalculatorConfiguration,
        accessibilityIdentifier: String? = nil
    ) {
        self.viewModels = viewModels
        self.renderConfiguration = renderConfiguration
        self.calculatorConfiguration = calculatorConfiguration
        self.accessibilityIdentifier = accessibilityIdentifier
    }
}

/// AnalyticsChartSpriteKit module input
public protocol AnalyticsChartSpriteKitModuleInput: class {
    func setChartViewModels(
        viewModels: [AnalyticsChartSpriteKitViewModel],
        silent: Bool
    )

    func setRangeValue(
        rangeValue: RangeValue<CGFloat>
    )

    func setChartLoadingState()

    func setChartIdleState()
}
