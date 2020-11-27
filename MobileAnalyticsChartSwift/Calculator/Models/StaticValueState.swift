import CoreGraphics

/// Type of static value state.
public enum StaticValueState {

    /// Static value will depend on the data set.
    case `default`

    /// Static value will have a specific value.
    case customValue(CGFloat)

    /// Static value will have boundary value.
    case boundaryValue(CGFloat)
}
