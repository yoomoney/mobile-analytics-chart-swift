import CoreGraphics
import Foundation

/// Type of chart data.
public struct ChartData {

    /// Chart value set.
    public let values: [CGFloat]

    /// Chart date set.
    public let dates: [Date]

    /// Creates instance of `ChartData`.
    ///
    /// - Parameters:
    ///     - values: Chart value set.
    ///     - dates: Chart date set.
    ///
    /// - Returns: Instance of `ChartData`.
    public init(
        values: [CGFloat],
        dates: [Date]
    ) {
        self.values = values
        self.dates = dates
    }
}
