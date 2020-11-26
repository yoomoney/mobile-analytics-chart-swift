import UIKit

/// Type of chart definition line.
public struct ChartDefinitionLine {

    /// Color of the defining line.
    public let color: UIColor

    /// Width of the defining line.
    public let width: CGFloat

    /// Creates instance of `ChartDefinitionLine`.
    ///
    /// - Parameters:
    ///     - color: Color of the defining line.
    ///     - width: Width of the defining line.
    ///
    /// - Returns: Instance of `ChartDefinitionLine`.
    public init(
        color: UIColor,
        width: CGFloat
    ) {
        self.color = color
        self.width = width
    }
}

/// Type of chart definition point.
public struct ChartDefinitionPoint {

    /// Minimum radius of the defining point.
    public let minRadius: CGFloat

    /// Maximum radius of the defining point.
    public let maxRadius: CGFloat

    /// Creates instance of `ChartDefinitionPoint`.
    ///
    /// - Parameters:
    ///     - minRadius: Minimum radius of the defining point.
    ///     - maxRadius: Maximum radius of the defining point.
    ///
    /// - Returns: Instance of `ChartDefinitionPoint`.
    public init(
        minRadius: CGFloat,
        maxRadius: CGFloat
    ) {
        self.minRadius = minRadius
        self.maxRadius = maxRadius
    }
}

/// Type of chart definition view.
public struct ChartDefinitionView {

    /// Background color of definition view.
    public let backgroundColor: UIColor

    /// Font of value label on definition view.
    public let valueLabelFont: UIFont

    /// Color of value label on definition view.
    public let valueLabelColor: UIColor

    /// Font of date label on definition view.
    public let dateLabelFont: UIFont

    /// Color of date label on definition view.
    public let dateLabelColor: UIColor

    /// Date formatter of label on definition view.
    public let dateFormatter: DateFormatter

    /// Creates instance of `ChartDefinitionView`.
    ///
    /// - Parameters:
    ///     - backgroundColor: Background color of definition view.
    ///     - valueLabelFont: Font of value label on definition view.
    ///     - valueLabelColor: Color of value label on definition view.
    ///     - dateLabelFont: Font of date label on definition view.
    ///     - dateLabelColor: Color of date label on definition view.
    ///     - dateFormatter: Date formatter of label on definition view.
    ///
    /// - Returns: Instance of `ChartDefinitionView`.
    public init(
        backgroundColor: UIColor,
        valueLabelFont: UIFont,
        valueLabelColor: UIColor,
        dateLabelFont: UIFont,
        dateLabelColor: UIColor,
        dateFormatter: DateFormatter
    ) {
        self.backgroundColor = backgroundColor
        self.valueLabelFont = valueLabelFont
        self.valueLabelColor = valueLabelColor
        self.dateLabelFont = dateLabelFont
        self.dateLabelColor = dateLabelColor
        self.dateFormatter = dateFormatter
    }
}

/// Type of chart definition.
public struct ChartDefinition {

    /// Entity of chart definition line.
    public let line: ChartDefinitionLine

    /// Entity of chart definition point.
    public let point: ChartDefinitionPoint

    /// Entity of chart definition view.
    public let view: ChartDefinitionView

    /// Fade animation for the difining point.
    public let fadeAnimation: ChartFadeAnimation

    /// Creates instance of `ChartDefinition`.
    ///
    /// - Parameters:
    ///     - line: Entity of chart definition line.
    ///     - point: Entity of chart definition point.
    ///     - view: Entity of chart definition view.
    ///     - fadeAnimation: Fade animation for the difining point.
    ///
    /// - Returns: Instance of `ChartDefinition`.
    public init(
        line: ChartDefinitionLine,
        point: ChartDefinitionPoint,
        view: ChartDefinitionView,
        fadeAnimation: ChartFadeAnimation
    ) {
        self.line = line
        self.point = point
        self.view = view
        self.fadeAnimation = fadeAnimation
    }
}
