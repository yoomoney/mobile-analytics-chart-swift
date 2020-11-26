/// Type of chat render configuration.
public struct ChartRenderConfiguration {

    /// Entity of analytics unit.
    public var unit: AnalyticsUnit

    /// Entity of chart path.
    public let path: ChartPath

    /// Entity of chart gradient.
    public let gradient: Gradient?

    /// Creates instance of `ChartRenderConfiguration`.
    ///
    /// - Parameters:
    ///     - unit: Entity of analytics unit.
    ///     - path: Entity of chart path.
    ///     - gradient: Entity of chart gradient.
    ///
    /// - Returns: Instance of `ChartRenderConfiguration`.
    public init(
        unit: AnalyticsUnit,
        path: ChartPath,
        gradient: Gradient?
    ) {
        self.unit = unit
        self.path = path
        self.gradient = gradient
    }
}
