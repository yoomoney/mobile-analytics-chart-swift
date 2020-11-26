import UIKit

/// Type of chart animation.
public struct ChartAnimation {

    /// Chart redraw duration.
    public let redrawDuration: TimeInterval

    /// Creates instance of `ChartAnimation`.
    ///
    /// - Parameters:
    ///     - redrawDuration: Chart redraw duration.
    ///
    /// - Returns: Instance of `ChartAnimation`.
    public init(
        redrawDuration: TimeInterval
    ) {
        self.redrawDuration = redrawDuration
    }
}
