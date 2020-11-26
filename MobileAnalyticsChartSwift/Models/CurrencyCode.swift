public enum CurrencyCode: RawRepresentable, Codable, Equatable {
    case rub
    case usd
    case eur
    case byn
    case kzt
    case unknown(String)
}

/// Making currency symbol.
public extension CurrencyCode {

    /// Symbol of currency.
    var currencySymbol: String {
        let result: String
        switch self {
        case .rub:
            result = "₽"
        case .usd:
            result = "$"
        case .eur:
            result = "€"
        case .byn:
            result = "Br"
        case .kzt:
            result = "₸"
        case .unknown(let value):
            result = value
        }
        return result
    }
}

// MARK: - RawRepresentable.
// swiftlint:disable missing_docs
public extension CurrencyCode {

    private enum _SupportedCurrency: String {
        case rub = "RUB"
        case usd = "USD"
        case eur = "EUR"
        case byn = "BYN"
        case kzt = "KZT"
    }

    /// Typealias RawValue for CurrencyCode.
    typealias RawValue = String

    /// Creates instance of `CurrencyCode`.
    ///
    /// - Parameters:
    ///     - rawValue: RawValue of CurrencyCode.
    ///
    /// - Returns: Instance of `CurrencyCode`.
    init(rawValue: CurrencyCode.RawValue) {
        if let supportedCurrency = _SupportedCurrency(rawValue: rawValue) {
            switch supportedCurrency {
            case .rub:
                self = .rub
            case .usd:
                self = .usd
            case .eur:
                self = .eur
            case .byn:
                self = .byn
            case .kzt:
                self = .kzt
            }
        } else {
            self = .unknown(rawValue)
        }
    }

    /// RawValue for CurrencyCode.
    var rawValue: CurrencyCode.RawValue {
        switch self {
        case .rub:
            return _SupportedCurrency.rub.rawValue
        case .usd:
            return _SupportedCurrency.usd.rawValue
        case .eur:
            return _SupportedCurrency.eur.rawValue
        case .byn:
            return _SupportedCurrency.byn.rawValue
        case .kzt:
            return _SupportedCurrency.kzt.rawValue
        case .unknown(let value):
            return value
        }
    }
}

// MARK: - Codable.

public extension CurrencyCode {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self.init(rawValue: value)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
// swiftlint:enable missing_docs
