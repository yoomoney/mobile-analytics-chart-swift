/// Type of range value.
public struct RangeValue<T> {

    /// Lower value.
    public var lowerValue: T

    /// Upper value.
    public var upperValue: T

    /// Creates instance of `RangeValue`.
    ///
    /// - Parameters:
    ///     - lowerValue: Lower value.
    ///     - upperValue: Upper value.
    ///
    /// - Returns: Instance of `RangeValue`.
    public init(
        lowerValue: T,
        upperValue: T
    ) {
        self.lowerValue = lowerValue
        self.upperValue = upperValue
    }
}
