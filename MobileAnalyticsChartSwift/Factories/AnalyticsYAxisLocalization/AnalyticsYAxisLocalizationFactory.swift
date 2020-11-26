import CoreGraphics

/// Protocol of analytics y axis localization factory.
public protocol AnalyticsYAxisLocalizationFactory {

    /// Make y axis text from value.
    func makeYAxisText(
        _ value: CGFloat
    ) -> String
}
