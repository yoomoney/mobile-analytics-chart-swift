import UIKit

/// Implementation of analytics y axis localization factory.
final public class AnalyticsYAxisLocalizationFactoryImpl {}

// MARK: - AnalyticsYAxisLocalizationFactory

extension AnalyticsYAxisLocalizationFactoryImpl: AnalyticsYAxisLocalizationFactory {
    public func makeYAxisText(
        _ value: CGFloat
    ) -> String {
        let text: String
        switch abs(value) {
        case Constants.thousandRange:
            let rangeValue = value / Constants.thousandRange.lowerBound
            let format = makeCorrectFormat(value: rangeValue)
            text = String(
                format: format + " %@",
                rangeValue,
                Localized.Text.thousand
            )
        case Constants.millionRange:
            let rangeValue = value / Constants.millionRange.lowerBound
            let format = makeCorrectFormat(value: rangeValue)
            text = String(
                format: format + " %@",
                rangeValue,
                Localized.Text.million
            )
        case Constants.billionRange:
            let rangeValue = value / Constants.billionRange.lowerBound
            let format = makeCorrectFormat(value: rangeValue)
            text = String(
                format: format + " %@",
                rangeValue,
                Localized.Text.billion
            )
        default:
            let rangeValue = value
            let format = makeCorrectFormat(value: rangeValue)
            text = String(
                format: format,
                rangeValue
            )
        }
        return text
    }
}

// MARK: - Localized

private extension AnalyticsYAxisLocalizationFactoryImpl {
    enum Localized {
        // swiftlint:disable line_length
        enum Text {
            static let thousand = NSLocalizedString(
                "AnalyticsYAxis.Text.Thousand",
                value: "тыс.",
                comment: "Text для сокращения тысяч на оси Y"
            )
            static let million = NSLocalizedString(
                "AnalyticsYAxis.Text.Million",
                value: "млн.",
                comment: "Text для сокращения миллионов на оси Y"
            )
            static let billion = NSLocalizedString(
                "AnalyticsYAxis.Text.Billion",
                value: "млрд.",
                comment: "Text для сокращения миллиардов на оси Y"
            )
        }
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

extension AnalyticsYAxisLocalizationFactoryImpl {
    private enum Constants {
        static let thousandRange: Range<CGFloat> = pow(10, 3) ..< pow(10, 6)
        static let millionRange: Range<CGFloat> = pow(10, 6) ..< pow(10, 9)
        static let billionRange: Range<CGFloat> = pow(10, 9) ..< .greatestFiniteMagnitude
    }
}

// MARK: - Private scope

func makeCorrectFormat(
    value: CGFloat
) -> String {
    let format: String
    let truncValue = CGFloat(round(10 * value) / 10)
    let roundedValue = round(value)
    if roundedValue != truncValue {
        format = "%.1f"
    } else {
        format = "%.0f"
    }
    return format
}
