import struct Foundation.Decimal

public struct MonetaryAmount: Equatable {

    public let value: Decimal
    public let currency: CurrencyCode

    public init(value: Decimal, currency: CurrencyCode) {
        self.value = value
        self.currency = currency
    }
}
