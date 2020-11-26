import UIKit

/// Type of chart fade animation.
public struct ChartFadeAnimation {

    /// Key for fade animation.
    public let key: String

    /// Color of fadeOut animation.
    public let fadeOutColor: UIColor

    /// Color of fadeIn animation.
    public let fadeInColor: UIColor

    /// Animation start duration.
    public let startDuration: TimeInterval

    /// FadeOut animation duration.
    public let fadeOutDuration: TimeInterval

    /// FadeIn animation duration.
    public let fadeInDuration: TimeInterval

    /// Creates instance of `ChartFadeAnimation`.
    ///
    /// - Parameters:
    ///     - key: Key for fade animation.
    ///     - fadeOutColor: Color of fadeOut animation.
    ///     - fadeInColor: Color of fadeIn animation.
    ///     - startDuration: Animation start duration.
    ///     - fadeOutDuration: FadeOut animation duration.
    ///     - fadeInDuration: FadeIn animation duration.
    ///
    /// - Returns: Instance of `ChartFadeAnimation`.
    public init(
        key: String = "fade_key",
        fadeOutColor: UIColor,
        fadeInColor: UIColor,
        startDuration: TimeInterval,
        fadeOutDuration: TimeInterval,
        fadeInDuration: TimeInterval
    ) {
        self.key = key
        self.fadeOutColor = fadeOutColor
        self.fadeInColor = fadeInColor
        self.startDuration = startDuration
        self.fadeOutDuration = fadeOutDuration
        self.fadeInDuration = fadeInDuration
    }
}
