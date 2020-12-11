import UIKit

/// Type of render configuration.
public struct RenderConfiguration {

    /// Entity of chart range label.
    public let rangeLabel: ChartRangeLabel?

    /// Entity of chart x axis.
    public let xAxis: ChartXAxis?

    /// Entity of chart y axis.
    public let yAxis: ChartYAxis?

    /// Entity of chart zero line.
    public let zeroLine: ChartZeroLine?

    /// Entity of chart gesture state.
    public let gestureState: ChartGestureState

    /// Entity of chart animation.
    public let animation: ChartAnimation

    /// Entity of chart definition.
    public let definition: ChartDefinition?

    /// Background chart color.
    public let backgroundColor: UIColor

    /// Insets of chart.
    public let chartInsets: UIEdgeInsets

    /// Margins of chart.
    public let chartMargins: UIEdgeInsets

    /// Duration of fadeIn animation.
    public let fadeInDuration: TimeInterval

    /// Duration of fadeOut animation.
    public let fadeOutDuration: TimeInterval

    /// Creates instance of `RenderConfiguration`.
    ///
    /// - Parameters:
    ///     - rangeLabel: Entity of chart range label.
    ///     - xAxis: Entity of chart x axis.
    ///     - yAxis: Entity of chart y axis.
    ///     - zeroLine: Entity of chart zero line.
    ///     - gestureState: Entity of chart gesture state.
    ///     - animation: Entity of chart animation.
    ///     - definition: Entity of chart definition.
    ///     - backgroundColor: Background chart color.
    ///     - chartInsets: Insets of chart.
    ///     - chartMargins: Margins of chart.
    ///     - fadeInDuration: Duration of fadeIn animation.
    ///     - fadeOutDuration: Duration of fadeOut animation.
    ///
    /// - Returns: Instance of `RenderConfiguration`.
    public init(
        rangeLabel: ChartRangeLabel?,
        xAxis: ChartXAxis?,
        yAxis: ChartYAxis?,
        zeroLine: ChartZeroLine?,
        gestureState: ChartGestureState,
        animation: ChartAnimation,
        definition: ChartDefinition?,
        backgroundColor: UIColor,
        chartInsets: UIEdgeInsets,
        chartMargins: UIEdgeInsets,
        fadeInDuration: TimeInterval,
        fadeOutDuration: TimeInterval
    ) {
        self.rangeLabel = rangeLabel
        self.xAxis = xAxis
        self.yAxis = yAxis
        self.zeroLine = zeroLine
        self.gestureState = gestureState
        self.animation = animation
        self.definition = definition
        self.backgroundColor = backgroundColor
        self.chartInsets = chartInsets
        self.chartMargins = chartMargins
        self.fadeInDuration = fadeInDuration
        self.fadeOutDuration = fadeOutDuration
    }
}
