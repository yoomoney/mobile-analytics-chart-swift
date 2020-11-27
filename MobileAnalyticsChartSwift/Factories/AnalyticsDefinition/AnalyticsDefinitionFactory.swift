import CoreGraphics

/// Protocol of analytics definition factory.
public protocol AnalyticsDefinitionFactory {

    /// Make definition text from value and unit.
    func makeDefinitionText(
        _ value: CGFloat,
        unit: AnalyticsUnit
    ) -> String?
}
