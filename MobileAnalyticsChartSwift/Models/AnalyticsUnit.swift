/// Entity of unit.
public enum AnalyticsUnit: Equatable {

    /// Unit is given as a quantity.
    case quantity

    /// Unit is given as a currency.
    case currency(CurrencyCode)

    /// Unsupported unit.
    case unknown(String)
}
