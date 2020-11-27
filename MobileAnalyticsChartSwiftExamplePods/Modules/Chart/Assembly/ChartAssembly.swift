import UIKit

enum ChartAssembly {
    static func makeModule(
        inputData: AnalyticsChartViewModel
    ) -> UIViewController {
        let view = ChartViewController()

        let presenter = ChartPresenter(analyticsChartViewModel: inputData)

        view.output = presenter

        presenter.view = view

        return view
    }
}
