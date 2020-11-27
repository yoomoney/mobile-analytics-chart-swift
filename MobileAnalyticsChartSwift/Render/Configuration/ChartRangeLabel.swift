import UIKit

/// Type of chart range label.
public struct ChartRangeLabel {

    /// Color of label.
    public let color: UIColor

    /// Font of label.
    public let font: UIFont

    /// Date formatter of label.
    public let dateFormatter: DateFormatter

    /// Insets of range label.
    public let insets: UIEdgeInsets

    /// Creates instance of `ChartRangeLabel`.
    ///
    /// - Parameters:
    ///     - color: Color of label.
    ///     - font: Font of label.
    ///     - dateFormatter: Date formatter of label.
    ///     - insets: Insets of range label.
    ///
    /// - Returns: Instance of `ChartRangeLabel`.
    public init(
        color: UIColor,
        font: UIFont,
        dateFormatter: DateFormatter,
        insets: UIEdgeInsets
    ) {
        self.color = color
        self.font = font
        self.dateFormatter = dateFormatter
        self.insets = insets
    }
}
