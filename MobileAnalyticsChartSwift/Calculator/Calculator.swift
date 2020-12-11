import CoreGraphics
import UIKit

/// Protocol of Calculator.
public protocol Calculator {

    /// Minimum value in visible range.
    var minValue: CGFloat? { get }

    /// Maximum value in the visible range.
    var maxValue: CGFloat? { get }

    /// Create points for charts.
    func makeChartsPoints(
        frame: CGRect,
        chartMargins: UIEdgeInsets,
        minValue: CGFloat?,
        maxValue: CGFloat?
    ) -> [[CGPoint]]

    /// Create a new range based on a change location.
    func makeRangeValue(
        deltaLocation: CGFloat,
        frameWidth: CGFloat
    ) -> RangeValue<CGFloat>?

    /// Create a new range based on a change scale.
    func makeRangeValue(
        scale: CGFloat
    ) -> RangeValue<CGFloat>?

    /// Set a new range of values.
    func setRangeValue(
        rangeValue: RangeValue<CGFloat>
    )

    /// Make total count values on x axis and
    /// x axis visible values with a position on the x axis and a value at that point.
    func makeXAxis(
        frame: CGRect,
        leftInset: CGFloat,
        rightInset: CGFloat,
        minCount: Int,
        zoomFactor: CGFloat
    ) -> [ChartXAxisValue]

    /// Make y coordinate for lines on the y axis.
    func makeYAxisLines(
        frame: CGRect,
        labelHeight: CGFloat,
        labelInsets: UIEdgeInsets,
        linesCount: Int
    ) -> [(start: CGPoint, end: CGPoint)]

    /// Make position and value for labels on the y axis.
    func makeYAxisValues(
        frame: CGRect,
        chartMargins: UIEdgeInsets,
        labelHeight: CGFloat,
        labelInsets: UIEdgeInsets,
        linesCount: Int
    ) -> [(position: CGPoint, value: CGFloat)]

    /// Make zero line coordinate for zero line.
    func makeZeroLine(
        frame: CGRect,
        chartMargins: UIEdgeInsets,
        minValue: CGFloat?,
        maxValue: CGFloat?
    ) -> (start: CGPoint, end: CGPoint)?

    /// Make dates for range diapasone.
    func makeRangeDates() -> (start: Date, end: Date?)?

    /// Make definition value, position for point and positions for line.
    func makeDefinition(
        frame: CGRect,
        chartMargins: UIEdgeInsets,
        definitionPosition: CGPoint,
        minValue: CGFloat?,
        maxValue: CGFloat?
    ) -> ChartDefinitionValues?

    /// Calculate line width.
    func calculateLineWidth(
        index: Int,
        minLineWidth: CGFloat,
        maxLineWidth: CGFloat
    ) -> CGFloat

    /// Return true if number of values equal 1.
    func isAlwaysDrawDefinition() -> Bool

    /// Return true if values is not empty.
    func isNeedDrawChart() -> Bool
}
