import CoreGraphics

/// Implementation of analytics definition factory.
final public class AnalyticsDefinitionFactoryImpl {

    private lazy var monetaryAmountFormatter: MonetaryAmountFormatter = {
        let formatter = MonetaryAmountFormatter()
        return formatter
    }()

    /// Creates instance of `AnalyticsDefinitionFactoryImpl`.
    ///
    /// - Returns: Instance of `AnalyticsDefinitionFactoryImpl`.
    public init() {}
}

// MARK: - AnalyticsDefinitionFactory

extension AnalyticsDefinitionFactoryImpl: AnalyticsDefinitionFactory {
    public func makeDefinitionText(
        _ value: CGFloat,
        unit: AnalyticsUnit
    ) -> String? {
        let text: String?
        switch unit {
        case .quantity:
            text = "\(Int(value))"
        case .currency(let currencyCode):
            text = monetaryAmountFormatter.format(value, currencySymbol: currencyCode.currencySymbol)
        case .unknown:
            assertionFailure("AnalyticsUnit shouldn't be unknown")
            text = nil
        }
        return text
    }
}
