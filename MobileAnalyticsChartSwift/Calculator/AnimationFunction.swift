import CoreGraphics

/// Cubic ease out function.
/// x and result in [0...1].
public func cubicEaseOut(
    _ x: CGFloat
) -> CGFloat {
    let p = x - 1
    return p * p * p + 1
}
