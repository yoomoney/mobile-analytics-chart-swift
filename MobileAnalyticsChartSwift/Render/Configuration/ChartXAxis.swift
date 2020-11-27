import UIKit

/// Type of chart x axis.
public struct ChartXAxis {

    /// Color of labels.
    public let labelColor: UIColor

    /// Font of labels.
    public let labelFont: UIFont

    /// Date formatter for labels.
    public let dateFormatter: DateFormatter

    /// Insets of x axis.
    public let insets: UIEdgeInsets

    /// Margins of x axis.
    public let margins: UIEdgeInsets

    /// Minimum number of labels on x axis.
    public let minCountLabels: Int

    /// Factor of zoom for labels on x axis.
    public let zoomFactorLabels: CGFloat

    /// Creates instance of `ChartXAxis`.
    ///
    /// - Parameters:
    ///     - labelColor: Color of labels.
    ///     - labelFont: Font of labels.
    ///     - dateFormatter: Date formatter for labels.
    ///     - insets: Insets of x axis.
    ///     - margins: Margins of x axis.
    ///     - minCountLabels: Minimum number of labels on x axis.
    ///     - zoomFactorLabels: Factor of zoom for labels on x axis.
    ///
    /// - Returns: Instance of `ChartXAxis`.
    public init(
        labelColor: UIColor,
        labelFont: UIFont,
        dateFormatter: DateFormatter,
        insets: UIEdgeInsets,
        margins: UIEdgeInsets,
        minCountLabels: Int = 4,
        zoomFactorLabels: CGFloat = 1.0
    ) {
        self.labelColor = labelColor
        self.labelFont = labelFont
        self.dateFormatter = dateFormatter
        self.insets = insets
        self.margins = margins
        self.minCountLabels = minCountLabels
        self.zoomFactorLabels = zoomFactorLabels
    }
}
