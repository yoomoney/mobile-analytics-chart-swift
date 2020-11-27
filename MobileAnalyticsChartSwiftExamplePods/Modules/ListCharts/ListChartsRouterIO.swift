import UIKit

protocol ListChartsRouterInput: class {
    func openChartModule(
        inputData: AnalyticsChartViewModel
    )

    func openCustomChartModule(
        inputData: AnalyticsChartViewModel
    )

    func openMultiselectChartsModule(
        inputData: AnalyticsChartViewModel
    )
}
