import MobileAnalyticsChartSwift
import UIKit

enum AnalyticsChartType {
    case `default`
    case custom
    case multiselect
}

// swiftlint:disable missing_docs
struct AnalyticsChartViewModel {
    public let title: String
    public let type: AnalyticsChartType
    public let data: AnalyticsChartSpriteKitModuleInputData
}
// swiftlint:enable missing_docs
