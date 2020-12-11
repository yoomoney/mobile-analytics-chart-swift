import UIKit

/// Type of chart zero line.
public struct ChartZeroLine {

    /// Color of line.
    public let color: UIColor

    /// Width of line.
    public let width: CGFloat

    /// Creates instance of `ChartZeroLine`.
    ///
    /// - Parameters:
    ///     - color: Color of line.
    ///     - width: Width of line.
    ///
    /// - Returns: Instance of `ChartZeroLine`.
    public init(
        color: UIColor,
        width: CGFloat
    ) {
        self.color = color
        self.width = width
    }
}
