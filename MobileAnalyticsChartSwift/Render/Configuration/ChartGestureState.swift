/// Type of chart gesture state.
public struct ChartGestureState {

    /// Active state of swipe gesture.
    public let swipeIsActive: Bool

    /// Active state of pinch gesture.
    public let pinchIsActive: Bool

    /// Active state of handle gesture.
    public let handleIsActive: Bool

    /// Creates instance of `ChartGestureState`.
    ///
    /// - Parameters:
    ///     - swipeIsActive: Active state of swipe gesture.
    ///     - pinchIsActive: Active state of pinch gesture.
    ///     - handleIsActive: Active state of handle gesture.
    ///
    /// - Returns: Instance of `ChartGestureState`.
    public init(
        swipeIsActive: Bool,
        pinchIsActive: Bool,
        handleIsActive: Bool
    ) {
        self.swipeIsActive = swipeIsActive
        self.pinchIsActive = pinchIsActive
        self.handleIsActive = handleIsActive
    }
}
