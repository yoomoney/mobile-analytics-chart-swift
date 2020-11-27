import UIKit

/// ViewModel of AnalyticsChartSpriteKit.
public struct AnalyticsChartSpriteKitViewModel {

    /// Entity of ChartData.
    public let data: ChartData

    /// Entity of ChartRenderConfiguration.
    public let configuration: ChartRenderConfiguration

    /// Accessibility identifier.
    public let accessibilityIdentifier: String?

    /// Creates instance of `AnalyticsChartSpriteKitViewModel`.
    ///
    /// - Parameters:
    ///     - data: Entity of ChartData.
    ///     - configuration: Entity of ChartRenderConfiguration.
    ///     - accessibilityIdentifier: Accessibility identifier.
    ///
    /// - Returns: Instance of `AnalyticsChartSpriteKitViewModel`.
    public init(
        data: ChartData,
        configuration: ChartRenderConfiguration,
        accessibilityIdentifier: String? = nil
    ) {
        self.data = data
        self.configuration = configuration
        self.accessibilityIdentifier = accessibilityIdentifier
    }
}
