import UIKit

enum CustomChartAssembly {
    static func makeModule(
        inputData: AnalyticsChartViewModel
    ) -> UIViewController {
        let view = CustomChartViewController()

        let presenter = CustomChartPresenter(analyticsChartViewModel: inputData)

        view.output = presenter

        presenter.view = view

        return view
    }
}
