import CoreGraphics

/// Type of calculator configuration.
public struct CalculatorConfiguration {

    /// Minimum static value. If minStaticValue == nil then minimum will change dynamically.
    public let minStaticValue: StaticValueState?

    /// Maximum static value. If maxStaticValue == nil then Maximum will change dynamically.
    public let maxStaticValue: StaticValueState?

    /// Initial value of the lower. Takes a value in the range [0...1].
    public let initialLowerValue: CGFloat

    /// Initial value of the upper. Takes a value in the range [0...1].
    public let initialUpperValue: CGFloat

    /// Minimum count of visible points on the chart.
    public let minimumCountVisibleValues: Int

    /// Line width reduction range based on the number of points on the chart.
    /// Before lower bound line width will be equal maximum line width.
    /// After upper bound line width will be equal minimum line width.
    public let rangeLineWidthReduction: Range<Int>

    /// Creates instance of `CalculatorConfiguration`.
    ///
    /// - Parameters:
    ///     - minStaticValue: Minimum static value. If minStaticValue == nil then minimum will change dynamically.
    ///     - maxStaticValue: Maximum static value. If maxStaticValue == nil then Maximum will change dynamically.
    ///     - initialLowerValue: Initial value of the lower. Takes a value in the range [0...1].
    ///     - initialUpperValue: Initial value of the upper. Takes a value in the range [0...1].
    ///     - minimumCountVisibleValues: Minimum count of visible points on the chart.
    ///     - rangeLineWidthReduction: Line width reduction range based on the number of points on the chart.
    ///                                Before lower bound line width will be equal maximum line width.
    ///                                After upper bound line width will be equal minimum line width.
    ///
    /// - Returns: Instance of `CalculatorConfiguration`.
    public init(
        minStaticValue: StaticValueState?,
        maxStaticValue: StaticValueState?,
        initialLowerValue: CGFloat = 0.0,
        initialUpperValue: CGFloat = 1.0,
        minimumCountVisibleValues: Int = 4,
        rangeLineWidthReduction: Range<Int> = 10 ..< 100
    ) {
        self.minStaticValue = minStaticValue
        self.maxStaticValue = maxStaticValue
        self.initialLowerValue = initialLowerValue
        self.initialUpperValue = initialUpperValue
        self.minimumCountVisibleValues = minimumCountVisibleValues
        self.rangeLineWidthReduction = rangeLineWidthReduction
    }
}
