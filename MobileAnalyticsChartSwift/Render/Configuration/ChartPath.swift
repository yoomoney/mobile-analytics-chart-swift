import UIKit

/// Type of chart path.
public struct ChartPath {

    /// Entity of path type.
    public let type: ChartPathType

    /// Color of chart path.
    public let color: UIColor

    /// Minimum width of chart path.
    public let minWidth: CGFloat

    /// Maximum width of chart path.
    public let maxWidth: CGFloat

    /// Entity of chart fade animation.
    public let fadeAnimation: ChartFadeAnimation

    /// Creates instance of `ChartPath`.
    ///
    /// - Parameters:
    ///     - type: Entity of path type.
    ///     - color: Color of chart path.
    ///     - minWidth: Minimum width of chart path.
    ///     - maxWidth: Maximum width of chart path.
    ///     - fadeAnimation: Entity of chart fade animation.
    ///
    /// - Returns: Instance of `ChartPath`.
    public init(
        type: ChartPathType,
        color: UIColor,
        minWidth: CGFloat,
        maxWidth: CGFloat,
        fadeAnimation: ChartFadeAnimation
    ) {
        self.type = type
        self.color = color
        self.minWidth = minWidth
        self.maxWidth = maxWidth
        self.fadeAnimation = fadeAnimation
    }
}
