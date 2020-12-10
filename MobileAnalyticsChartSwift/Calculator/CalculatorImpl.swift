import Foundation
import UIKit

/// Implementation of calculator.
public class CalculatorImpl {

    // MARK: - Init data

    /// Array of chart data.
    private var data: [ChartData]

    /// Calculator configuration.
    private var configuration: CalculatorConfiguration

    /// Number of values.
    private(set) var valuesCount: Int

    /// Number of segments.
    private(set) var segmentsCount: Int?

    /// Value range. Takes a value in range [0...1].
    private(set) var rangeValue: RangeValue<CGFloat>

    /// Index range. Takes a value in range [0...segmentsCount].
    private(set) var rangeIndex: RangeValue<Int>?

    /// Boundary value range. Takes a value in range [values.min...values.max] or can take custom values.
    private(set) var rangeBoundaryValue: RangeValue<BoundaryValue>?

    // MARK: - Init

    /// Creates instance of `CalculatorImpl`.
    ///
    /// - Parameters:
    ///     - data: Array of chart data.
    ///     - configuration: Calculator configuration.
    ///     - valuesCount: Number of values.
    ///     - segmentsCount: Number of segments.
    ///     - rangeValue: Value range. Takes a value in range [0...1].
    ///     - rangeIndex: Index range. Takes a value in range [0...segmentsCount].
    ///     - rangeBoundaryValue: Boundary value range. Takes a value in range [values.min...values.max]
    ///                           or can take custom values.
    ///
    /// - Returns: Instance of `CalculatorImpl`.
    public init(
        data: [ChartData],
        configuration: CalculatorConfiguration
    ) {
        self.data = data
        self.configuration = configuration

        self.valuesCount = data.first?.values.count ?? 0
        self.segmentsCount = data.first?.values.isEmpty ?? true ? nil : valuesCount - 1
        self.rangeValue = RangeValue(
            lowerValue: configuration.initialLowerValue,
            upperValue: configuration.initialUpperValue
        )

        guard let segmentsCount = self.segmentsCount else { return }

        self.rangeIndex = RangeValue(
            lowerValue: makeLowerIndex(rangeValue.lowerValue, segmentsCount: segmentsCount),
            upperValue: makeUpperIndex(rangeValue.upperValue, segmentsCount: segmentsCount)
        )

        self.rangeBoundaryValue = makeBoundaryValues(
            values: visibleValuesInRange,
            minStaticValue: configuration.minStaticValue,
            maxStaticValue: configuration.maxStaticValue
        )
    }

    // MARK: - Data

    /// Minimum value in visible range.
    public var minValue: CGFloat? {
        get {
            switch rangeBoundaryValue?.lowerValue {
            case .customValue(let value):
                return value
            case .staticValue(let value):
                return value
            case .boundaryValue(let rangeValue):
                return min(rangeValue.lowerValue, rangeValue.upperValue)
            case .none:
                return nil
            }
        }
        set {
            switch rangeBoundaryValue?.lowerValue {
            case .customValue:
                if let newValue = newValue {
                    rangeBoundaryValue?.lowerValue = .customValue(newValue)
                } else {
                    rangeBoundaryValue = nil
                }
            case .staticValue:
                break
            case .boundaryValue(let rangeValue):
                if let newValue = newValue {
                    let newRangeValue = RangeValue<CGFloat>(
                        lowerValue: rangeValue.lowerValue,
                        upperValue: newValue
                    )
                    rangeBoundaryValue?.lowerValue = .boundaryValue(newRangeValue)
                } else {
                    rangeBoundaryValue = nil
                }
            case .none:
                break
            }
        }
    }

    /// Maximum value in the visible range.
    public var maxValue: CGFloat? {
        get {
            switch rangeBoundaryValue?.upperValue {
            case .customValue(let value):
                return value
            case .staticValue(let value):
                return value
            case .boundaryValue(let rangeValue):
                return max(rangeValue.lowerValue, rangeValue.upperValue)
            case .none:
                return nil
            }
        }
        set {
            switch rangeBoundaryValue?.upperValue {
            case .customValue:
                if let newValue = newValue {
                    rangeBoundaryValue?.upperValue = .customValue(newValue)
                } else {
                    rangeBoundaryValue = nil
                }
            case .staticValue:
                break
            case .boundaryValue(let rangeValue):
                if let newValue = newValue {
                    let newRangeValue = RangeValue<CGFloat>(
                        lowerValue: rangeValue.lowerValue,
                        upperValue: newValue
                    )
                    rangeBoundaryValue?.upperValue = .boundaryValue(newRangeValue)
                } else {
                    rangeBoundaryValue = nil
                }
            case .none:
                break
            }
        }
    }

    /// Absolute value max value - min value in the visible range.
    private var boundaryDiff: CGFloat? {
        guard let maxValue = maxValue,
              let minValue = minValue,
              maxValue != minValue else { return nil }
        return abs(maxValue - minValue)
    }

    /// Lower index in the visible range.
    private var lowerIndexValue: CGFloat? {
        guard let segmentsCount = segmentsCount else { return nil }
        return CGFloat(segmentsCount) * rangeValue.lowerValue
    }

    /// Upper index in the visible range.
    private var upperIndexValue: CGFloat? {
        guard let segmentsCount = segmentsCount else { return nil }
        return CGFloat(segmentsCount) * rangeValue.upperValue
    }

    /// Visible range of values.
    private var visibleValuesInRange: [[CGFloat]] {
        guard let rangeIndex = rangeIndex,
              rangeIndex.lowerValue >= 0,
              rangeIndex.lowerValue <= rangeIndex.upperValue,
              rangeIndex.upperValue < valuesCount else {
            return [[]]
        }
        return data.map { Array($0.values[rangeIndex.lowerValue ... rangeIndex.upperValue]) }
    }
}

extension CalculatorImpl: Calculator {

    public func makeChartsPoints(
        frame: CGRect,
        chartMargins: UIEdgeInsets,
        minValue: CGFloat?,
        maxValue: CGFloat?
    ) -> [[CGPoint]] {
        guard valuesCount != 0,
              let minValue = minValue ?? self.minValue,
              let maxValue = maxValue ?? self.maxValue,
              maxValue != minValue else {
            return []
        }

        let boundaryDiff = abs(maxValue - minValue)

        guard boundaryDiff > 0 else {
            return []
        }

        let height = frame.height
            - chartMargins.top
            - chartMargins.bottom
        let y = frame.minY
            + chartMargins.bottom

        guard valuesCount > 1 else {
            return data.map {
                let y = y + ($0.values[0] - minValue) / boundaryDiff * height
                let startPoint = CGPoint(
                    x: frame.minX,
                    y: y
                )
                let endPoint = CGPoint(
                    x: frame.maxX,
                    y: y
                )
                return [startPoint, endPoint]
            }
        }

        guard let rangeIndex = rangeIndex,
              let upperIndexValue = upperIndexValue,
              let lowerIndexValue = lowerIndexValue,
              upperIndexValue > lowerIndexValue else {
            return []
        }

        let segmentWidth = frame.width / (upperIndexValue - lowerIndexValue)
        let leftShift = segmentWidth * (lowerIndexValue - CGFloat(rangeIndex.lowerValue))

        return visibleValuesInRange.map {
            $0.enumerated().map {
                CGPoint(
                    x: frame.minX
                        + segmentWidth * CGFloat($0.offset)
                        - leftShift,
                    y: y + ($0.element - minValue) / boundaryDiff * height
                )
            }
        }
    }

    public func makeRangeValue(
        deltaLocation: CGFloat,
        frameWidth: CGFloat
    ) -> RangeValue<CGFloat>? {
        guard data.first?.values.count ?? 0 > 1,
              deltaLocation != 0,
              frameWidth > 0 else { return nil }

        var lowerValue = rangeValue.lowerValue
        var upperValue = rangeValue.upperValue
        let diff = upperValue - lowerValue

        var deltaValue = (-deltaLocation / frameWidth) * diff

        guard deltaValue > 0 && upperValue < 1.0
           || deltaValue < 0 && lowerValue > 0.0 else {
            return nil
        }

        if lowerValue + deltaValue < 0 {
            deltaValue = -lowerValue
        }

        if upperValue + deltaValue > 1 {
            deltaValue = 1.0 - upperValue
        }

        lowerValue += deltaValue
        upperValue += deltaValue

        return RangeValue(lowerValue: lowerValue, upperValue: upperValue)
    }

    public func makeRangeValue(
        scale: CGFloat
    ) -> RangeValue<CGFloat>? {
        guard data[0].values.count > 1,
              visibleValuesInRange[0].count > configuration.minimumCountVisibleValues || scale < 1 else { return nil }

        var lowerValue = rangeValue.lowerValue
        var upperValue = rangeValue.upperValue
        let diff = upperValue - lowerValue

        let deltaValue = (1 - scale) * diff

        lowerValue = boundValue(lowerValue - deltaValue, toLowerValue: 0.0, upperValue: 1.0)
        upperValue = boundValue(upperValue + deltaValue, toLowerValue: 0.0, upperValue: 1.0)

        return RangeValue(lowerValue: lowerValue, upperValue: upperValue)
    }

    public func setRangeValue(
        rangeValue: RangeValue<CGFloat>
    ) {
        guard rangeValue.lowerValue < rangeValue.upperValue,
              let rangeIndex = rangeIndex,
              let segmentsCount = segmentsCount else { return }

        self.rangeValue = rangeValue

        let oldLowerIndex = rangeIndex.lowerValue
        let oldUpperIndex = rangeIndex.upperValue
        let newLowerIndex = makeLowerIndex(rangeValue.lowerValue, segmentsCount: segmentsCount)
        let newUpperIndex = makeUpperIndex(rangeValue.upperValue, segmentsCount: segmentsCount)
        var needFindBoundaryValues: Bool = false

        if newLowerIndex < oldLowerIndex {
            if let boundaryValues = findBoundaryValues(data.map { Array($0.values[newLowerIndex ..< oldLowerIndex]) }) {
                setBoundaryValuesIfNeeded(boundaryValues)
            }
        }
        if newLowerIndex > oldLowerIndex {
            if let boundaryValues = findBoundaryValues(data.map { Array($0.values[oldLowerIndex ..< newLowerIndex]) }),
               needFindNewBoundaryValues(boundaryValues) {
                needFindBoundaryValues = true
            }
        }
        self.rangeIndex?.lowerValue = newLowerIndex

        if newUpperIndex > oldUpperIndex {
            if let boundaryValues = findBoundaryValues(
                data.map { Array($0.values[oldUpperIndex + 1 ... newUpperIndex]) }
            ) {
                setBoundaryValuesIfNeeded(boundaryValues)
            }
        }
        if newUpperIndex < oldUpperIndex {
            if let boundaryValues = findBoundaryValues(
                data.map { Array($0.values[newUpperIndex + 1 ... oldUpperIndex]) }
            ),
               needFindNewBoundaryValues(boundaryValues) {
                needFindBoundaryValues = true
            }
        }
        self.rangeIndex?.upperValue = newUpperIndex

        if needFindBoundaryValues {
            if let boundaryValues = findBoundaryValues(visibleValuesInRange) {
                setBoundaryValues(boundaryValues)
            }
        }
    }

    public func calculateLineWidth(
        index: Int,
        minLineWidth: CGFloat,
        maxLineWidth: CGFloat
    ) -> CGFloat {
        guard visibleValuesInRange.indices.contains(index) else {
            return 0
        }
        let valuesInRangeCount = visibleValuesInRange[index].count
        let rangeReduction = configuration.rangeLineWidthReduction
        switch valuesInRangeCount {
        case 0 ..< rangeReduction.lowerBound:
            return maxLineWidth
        case rangeReduction.lowerBound ..< rangeReduction.upperBound:
            let rangeCount = CGFloat(rangeReduction.count)
            let factor = CGFloat(valuesInRangeCount - rangeReduction.lowerBound)
                / rangeCount
            let cubicEaseOutFactor = cubicEaseOut(factor)
            return maxLineWidth - (maxLineWidth - minLineWidth) * cubicEaseOutFactor
        default:
            return minLineWidth
        }
    }

    public func makeXAxis(
        frame: CGRect,
        leftInset: CGFloat,
        rightInset: CGFloat,
        minCount: Int,
        zoomFactor: CGFloat
    ) -> [ChartXAxisValue] {
        let minCount = min(minCount, valuesCount)
        guard minCount > 0,
              let segmentsCount = segmentsCount else {
            return []
        }

        guard minCount > 1 else {
            return [
                ChartXAxisValue(
                    position: CGPoint(x: frame.width * 0.5 + frame.minX, y: frame.minY),
                    date: data[0].dates[0]
                ),
            ]
        }

        let diff = rangeValue.upperValue - rangeValue.lowerValue
        guard diff > 0 else {
            return []
        }

        let zoomCount = CGFloat(minCount) / diff
        let zoomPower = floor(log2(floor(zoomCount * zoomFactor))) - 2
        let totalCount = max(minCount, (minCount - 1) * Int(pow(2, zoomPower)) + 1)
        guard totalCount > 1 else {
            return []
        }

        let width = frame.width / diff
        let segmentWidth = width / CGFloat(segmentsCount)
        let labelWidth: CGFloat = 40.0 // TODO: Need remove constant or rewrite algorithm
        let fillWidth = labelWidth * CGFloat(totalCount) + leftInset + rightInset
        let spaceWidth = (width - fillWidth) / CGFloat(totalCount - 1)
        let lowerPositionX = width * rangeValue.lowerValue
        let upperPositionX = width * rangeValue.upperValue

        let elementWidth = labelWidth + spaceWidth
        let lowerIndexPosition = (lowerPositionX - labelWidth - leftInset - labelWidth * 0.5) / elementWidth
        let upperIndexPosition = (upperPositionX - leftInset + labelWidth * 0.5) / elementWidth
        var lowerXAxisIndex = max(0, Int(floor(lowerIndexPosition)))
        var upperXAxisIndex = min(totalCount, Int(ceil(upperIndexPosition)))

        if lowerXAxisIndex >= upperXAxisIndex {
            lowerXAxisIndex = 0
            upperXAxisIndex = totalCount
        }

        let values = (lowerXAxisIndex ..< upperXAxisIndex).compactMap {
            makeXAxisValue(
                index: $0,
                frame: frame,
                leftInset: leftInset,
                lowerPositionX: lowerPositionX,
                labelWidth: labelWidth,
                spaceWidth: spaceWidth,
                segmentWidth: segmentWidth
            )
        }
        return values
    }

    public func makeYAxisLines(
        frame: CGRect,
        labelHeight: CGFloat,
        labelInsets: UIEdgeInsets,
        linesCount: Int
    ) -> [(start: CGPoint, end: CGPoint)] {
        guard valuesCount > 0 else {
            return []
        }

        guard linesCount > 1 else {
            assertionFailure("Amount of lines should be more then 1")
            return []
        }

        let frameHeight = frame.height
            - labelHeight
            - labelInsets.top
            - labelInsets.bottom
        let segmentHeight = frameHeight / CGFloat(linesCount - 1)
        return (0 ..< linesCount).map {
            let y = frame.minY + segmentHeight * CGFloat($0)
            return (
                start: CGPoint(x: frame.minX, y: y),
                end: CGPoint(x: frame.maxX, y: y)
            )
        }
    }

    public func makeYAxisValues(
        frame: CGRect,
        chartMargins: UIEdgeInsets,
        labelHeight: CGFloat,
        labelInsets: UIEdgeInsets,
        linesCount: Int
    ) -> [(position: CGPoint, value: CGFloat)] {
        guard linesCount > 1 else {
            assertionFailure("Amount of lines should be more then 1")
            return []
        }

        let chartMargin = chartMargins.bottom + chartMargins.top
        let chartHeight = frame.height - chartMargin
        guard chartHeight > 0,
              let boundaryDiff = self.boundaryDiff else {
            return []
        }

        let labelAbsoluteHeight = labelHeight + labelInsets.top + labelInsets.bottom
        let alternativeBoundaryDiff = boundaryDiff * (1 + (chartMargin - labelAbsoluteHeight) / chartHeight)
        let alternativeMinValue = minValue ?? 0 * (1 + (chartMargin - labelAbsoluteHeight) / chartHeight)

        let frameHeight = frame.height - labelAbsoluteHeight
        let segmentHeight = frameHeight / CGFloat(linesCount - 1)
        let x = frame.minX + labelInsets.left
        return (0 ..< linesCount).map {
            let y = segmentHeight * CGFloat($0)
            return (
                position: CGPoint(x: x, y: y + frame.minY + labelInsets.bottom),
                value: (y / frameHeight) * alternativeBoundaryDiff + alternativeMinValue
            )
        }
    }

    public func makeZeroLine(
        frame: CGRect,
        chartMargins: UIEdgeInsets,
        minValue: CGFloat?,
        maxValue: CGFloat?
    ) -> (start: CGPoint, end: CGPoint)? {
        guard valuesCount != 0,
              let minValue = minValue ?? self.minValue,
              let maxValue = maxValue ?? self.maxValue,
              maxValue != minValue else {
            return nil
        }

        let boundaryDiff = abs(maxValue - minValue)

        guard boundaryDiff > 0 else {
            return nil
        }

        let height = frame.height
            - chartMargins.top
            - chartMargins.bottom
        let y = frame.minY
            + chartMargins.bottom
            - minValue / boundaryDiff * height

        return (
            start: CGPoint(x: frame.minX, y: y),
            end: CGPoint(x: frame.maxX, y: y)
        )
    }

    public func makeRangeDates() -> (start: Date, end: Date?)? {
        guard let start = data.first?.dates.first else {
            return nil
        }

        guard let end = data.first?.dates.last,
              end != start else {
            return (start: start, end: nil)
        }

        return (start: start, end: end)
    }

    public func makeDefinition(
        frame: CGRect,
        chartMargins: UIEdgeInsets,
        definitionPosition: CGPoint,
        minValue: CGFloat?,
        maxValue: CGFloat?
    ) -> ChartDefinitionValues? {
        guard let minValue = minValue ?? self.minValue,
              let maxValue = maxValue ?? self.maxValue,
              maxValue != minValue else {
            return nil
        }

        let boundaryDiff = abs(maxValue - minValue)

        guard let segmentsCount = segmentsCount,
              boundaryDiff > 0 else {
            return nil
        }

        let height = frame.height
            - chartMargins.top
            - chartMargins.bottom
        let y = frame.minY
            + chartMargins.bottom

        guard segmentsCount > 0 else {
            let positionX = frame.minX
                + frame.width * 0.5
            let lineStartPosition = CGPoint(
                x: positionX,
                y: frame.minY
            )
            let lineEndPosition = CGPoint(
                x: positionX,
                y: frame.maxY
            )

            let chartValues: [(value: CGFloat, pointPosition: CGPoint)] = data.map {
                let value = $0.values[0]
                let pointPosition = CGPoint(
                    x: frame.minX + frame.width * 0.5,
                    y: y + (value - minValue) / boundaryDiff * height
                )
                return (
                    value: value,
                    pointPosition: pointPosition
                )
            }
            return ChartDefinitionValues(
                date: data[0].dates[0],
                linePosition: (start: lineStartPosition, end: lineEndPosition),
                chartValues: chartValues
            )
        }

        let diff = rangeValue.upperValue - rangeValue.lowerValue
        guard diff > 0 else {
            return nil
        }

        let width = frame.width / diff
        guard width > 0 else {
            return nil
        }

        guard let upperIndexValue = upperIndexValue,
              let lowerIndexValue = lowerIndexValue,
              upperIndexValue > lowerIndexValue else {
            return nil
        }

        let segmentWidth = frame.width / (upperIndexValue - lowerIndexValue)
        let lowerPositionX = width * rangeValue.lowerValue
        let actualPositionX = lowerPositionX + definitionPosition.x
        let valueIndex = Int(round(actualPositionX / width * CGFloat(segmentsCount)))
        let positionX = frame.minX
            + segmentWidth * CGFloat(valueIndex)
            - width * rangeValue.lowerValue
        let lineStartPosition = CGPoint(
            x: positionX,
            y: frame.minY
        )
        let lineEndPosition = CGPoint(
            x: positionX,
            y: frame.maxY
        )

        let chartValues: [(value: CGFloat, pointPosition: CGPoint)] = data.map {
            let value = $0.values[valueIndex]
            let pointPosition = CGPoint(
                x: positionX,
                y: y + (value - minValue) / boundaryDiff * height
            )
            return (
                value: value,
                pointPosition: pointPosition
            )
        }

        return ChartDefinitionValues(
            date: data[0].dates[valueIndex],
            linePosition: (start: lineStartPosition, end: lineEndPosition),
            chartValues: chartValues
        )
    }

    public func isAlwaysDrawDefinition() -> Bool {
        return valuesCount == 1
    }

    public func isNeedDrawChart() -> Bool {
        return valuesCount > 0
    }

    /// A new minimum or maximum to be found in the case
    /// of adding or deleting points from the current minimum or maximum.
    private func needFindNewBoundaryValues(
        _ boundaryValues: RangeValue<CGFloat>
    ) -> Bool {
        return boundaryValues.lowerValue == minValue || boundaryValues.upperValue == maxValue
    }

    /// Set new boundary values for maximum and minimum.
    private func setBoundaryValues(
        _ boundaryValues: RangeValue<CGFloat>
    ) {
        minValue = boundaryValues.lowerValue
        maxValue = boundaryValues.upperValue
    }

    /// Set new boundary values for maximum and minimum if necessary.
    private func setBoundaryValuesIfNeeded(
        _ boundaryValues: RangeValue<CGFloat>
    ) {
        if let minValue = minValue {
            if boundaryValues.lowerValue < minValue {
                self.minValue = boundaryValues.lowerValue
            }
        } else {
            self.minValue = boundaryValues.lowerValue
        }

        if let maxValue = maxValue {
            if boundaryValues.upperValue > maxValue {
                self.maxValue = boundaryValues.upperValue
            }
        } else {
            self.maxValue = boundaryValues.upperValue
        }
    }

    /// Make x axis value with a position on the x axis and a value at that point
    private func makeXAxisValue(
        index: Int,
        frame: CGRect,
        leftInset: CGFloat,
        lowerPositionX: CGFloat,
        labelWidth: CGFloat,
        spaceWidth: CGFloat,
        segmentWidth: CGFloat
    ) -> ChartXAxisValue? {
        guard segmentWidth > 0 else {
            assertionFailure("Segment width should be more then 0")
            return nil
        }
        let positionX = leftInset
            + CGFloat(index) * (labelWidth + spaceWidth)
            - lowerPositionX
            + labelWidth * 0.5
        let positionY = frame.minY
        let position = CGPoint(x: positionX, y: positionY)
        let currentIndex = Int(round((positionX + lowerPositionX) / segmentWidth))

        return ChartXAxisValue(
            position: position,
            date: data[0].dates[currentIndex]
        )
    }
}

// MARK: - Private scope

/// Make boundary values based on values and static value state
private func makeBoundaryValues(
    values: [[CGFloat]],
    minStaticValue: StaticValueState?,
    maxStaticValue: StaticValueState?
) -> RangeValue<BoundaryValue>? {
    guard let boundaryValues = findBoundaryValues(values) else { return nil }

    let minCustomValue = values[0].count == 1
        ? makeMinCustomValue(from: values.map { $0[0] }.min() ?? 1)
        : boundaryValues.lowerValue
    let minBoundaryValue = makeBoundaryValue(
        from: minStaticValue,
        customValue: minCustomValue
    )

    let maxCustomValue = values[0].count == 1
        ? makeMaxCustomValue(from: values.map { $0[0] }.max() ?? 1)
        : boundaryValues.upperValue
    let maxBoundaryValue = makeBoundaryValue(
        from: maxStaticValue,
        customValue: maxCustomValue
    )

    return RangeValue(
        lowerValue: minBoundaryValue,
        upperValue: maxBoundaryValue
    )
}

private func makeMinCustomValue(
    from value: CGFloat
) -> CGFloat {
    if value > 0 {
        return 0
    } else if value < 0 {
        return value * 2
    } else {
        return 0
    }
}

private func makeMaxCustomValue(
    from value: CGFloat
) -> CGFloat {
    if value > 0 {
        return value * 2
    } else if value < 0 {
        return 0
    } else {
        return 1
    }
}

/// Make boundary value based on static value state and custom value.
private func makeBoundaryValue(
    from staticValue: StaticValueState?,
    customValue: CGFloat
) -> BoundaryValue {
    let boundaryValue: BoundaryValue
    switch staticValue {
    case .none:
        boundaryValue = .customValue(customValue)
    case .default:
        boundaryValue = .staticValue(customValue)
    case .customValue(let value):
        boundaryValue = .staticValue(value)
    case .boundaryValue(let value):
        let rangeValue = RangeValue<CGFloat>(
            lowerValue: value,
            upperValue: customValue
        )
        boundaryValue = .boundaryValue(rangeValue)
    }
    return boundaryValue
}

/// Find the boundary values of maximum and minimum in the data set.
private func findBoundaryValues(
    _ arrayValues: [[CGFloat]]
) -> RangeValue<CGFloat>? {
    guard arrayValues.isEmpty == false,
          arrayValues[0].isEmpty == false else { return nil }

    var min = arrayValues[0][0]
    var max = arrayValues[0][0]

    for values in arrayValues {
        for value in values {
            if value < min {
                min = value
            }
            if value > max {
                max = value
            }
        }
    }

    return RangeValue(lowerValue: min, upperValue: max)
}

/// Make lower index.
private func makeLowerIndex(
    _ value: CGFloat,
    segmentsCount: Int
) -> Int {
    return makeIndex(
        value: value,
        segmentsCount: CGFloat(segmentsCount),
        roundRule: .down
    )
}

/// Make upper index.
private func makeUpperIndex(
    _ value: CGFloat,
    segmentsCount: Int
) -> Int {
    return makeIndex(
        value: value,
        segmentsCount: CGFloat(segmentsCount),
        roundRule: .up
    )
}

/// Make index.
private func makeIndex(
    value: CGFloat,
    segmentsCount: CGFloat,
    roundRule: FloatingPointRoundingRule
) -> Int {
    let index = (segmentsCount * value).rounded(roundRule)
    return Int(index)
}

/// Make bound value based on lower value and upper value.
private func boundValue(
    _ value: CGFloat,
    toLowerValue lowerValue: CGFloat,
    upperValue: CGFloat
) -> CGFloat {
    return min(max(value, lowerValue), upperValue)
}
