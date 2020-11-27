import CoreGraphics

/// Type of boundary value.
public enum BoundaryValue {

    /// Cusom value. Boundary value can change.
    case customValue(CGFloat)

    /// Static value. Boundary value can't change and always has a static value.
    case staticValue(CGFloat)

    /// Boundary value.
    /// For minimum boundary value = min(boundaryValue, minValue)
    /// For maximum boundary value = max(boundaryValue, maxValue)
    case boundaryValue(RangeValue<CGFloat>)
}
