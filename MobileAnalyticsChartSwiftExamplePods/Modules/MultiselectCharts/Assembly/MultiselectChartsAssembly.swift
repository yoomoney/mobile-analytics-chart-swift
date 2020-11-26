import UIKit

enum MultiselectChartsAssembly {
    static func makeModule(
        inputData: AnalyticsChartViewModel
    ) -> UIViewController {
        let view = MultiselectChartsViewController()

        let presenter = MultiselectChartsPresenter(analyticsChartViewModel: inputData)

        view.output = presenter

        presenter.view = view

        return view
    }
}
