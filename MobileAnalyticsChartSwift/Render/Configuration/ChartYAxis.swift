import UIKit

/// Type of chart y axis.
public struct ChartYAxis {

    /// Color of labels.
    public let labelColor: UIColor

    /// Font of labels.
    public let labelFont: UIFont

    /// Insets of labels.
    public let labelInsets: UIEdgeInsets

    /// Color of lines.
    public let lineColor: UIColor

    /// Width of lines.
    public let lineWidth: CGFloat

    /// Number of lines.
    public let linesCount: Int

    /// Creates instance of `ChartYAxis`.
    ///
    /// - Parameters:
    ///     - labelColor: Color of labels.
    ///     - labelFont: Font of labels.
    ///     - labelInsets: Insets of labels.
    ///     - lineColor: Color of lines.
    ///     - lineWidth: Width of lines.
    ///     - linesCount: Number of lines.
    ///
    /// - Returns: Instance of `ChartYAxis`.
    public init(
        labelColor: UIColor,
        labelFont: UIFont,
        labelInsets: UIEdgeInsets,
        lineColor: UIColor,
        lineWidth: CGFloat,
        linesCount: Int = 4
    ) {
        self.labelColor = labelColor
        self.labelFont = labelFont
        self.labelInsets = labelInsets
        self.lineColor = lineColor
        self.lineWidth = lineWidth
        self.linesCount = linesCount
    }
}
