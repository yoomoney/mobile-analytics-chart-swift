import UIKit

/// Gradient directions of the chart.
public enum GradientDirection {

    /// From bottom to top.
    case up

    /// From left to right.
    case left

    /// From the lower right corner to the upper left.
    case upLeft

    /// From the lower left corner to the upper right.
    case upRight
}

/// Type of chart gradient.
public struct Gradient {

    /// First color.
    public let firstColor: UIColor

    /// Second color.
    public let secondColor: UIColor

    /// Direction of the gradient.
    public let direction: GradientDirection

    /// Fade animation of the gradient.
    public let fadeAnimation: ChartFadeAnimation

    /// Creates instance of `Gradient`.
    ///
    /// - Parameters:
    ///     - firstColor: Array of chart data.
    ///     - secondColor: Calculator configuration.
    ///     - direction: Number of values.
    ///     - fadeAnimation: Number of segments.
    ///
    /// - Returns: Instance of `Gradient`.
    public init(
        firstColor: UIColor,
        secondColor: UIColor,
        direction: GradientDirection = .up,
        fadeAnimation: ChartFadeAnimation
    ) {
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.direction = direction
        self.fadeAnimation = fadeAnimation
    }
}
