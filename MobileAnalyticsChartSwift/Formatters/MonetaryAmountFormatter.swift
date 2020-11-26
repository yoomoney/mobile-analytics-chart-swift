import UIKit

final class MonetaryAmountFormatter {

    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    func format(_ amount: MonetaryAmount) -> String {
        numberFormatter.currencySymbol = amount.currency.currencySymbol
        return numberFormatter.string(for: amount.value) ?? ""
    }

    func format(_ value: Decimal, currencySymbol: String) -> String {
        numberFormatter.currencySymbol = currencySymbol
        return numberFormatter.string(for: value) ?? ""
    }

    func format(_ value: Double, currencySymbol: String) -> String {
        numberFormatter.currencySymbol = currencySymbol
        return numberFormatter.string(for: value) ?? ""
    }

    func format(_ value: CGFloat, currencySymbol: String) -> String {
        numberFormatter.currencySymbol = currencySymbol
        return numberFormatter.string(for: value) ?? ""
    }

    func format(_ value: String, currencySymbol: String) -> Decimal {
        numberFormatter.currencySymbol = currencySymbol
        return numberFormatter.number(from: value)?.decimalValue ?? 0
    }

    // MARK: - Init

    /// Creates instance of `MonetaryAmountFormatter`.
    ///
    /// - Returns: Instance of `MonetaryAmountFormatter`.
    public init() {}
}
