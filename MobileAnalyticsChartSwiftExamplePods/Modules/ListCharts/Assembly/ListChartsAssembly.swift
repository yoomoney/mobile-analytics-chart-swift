import UIKit

enum ListChartsAssembly {
    static func makeModule() -> UIViewController {
        let view = ListChartsViewController()

        let analyticsChartFactory = AnalyticsChartFactoryImpl()
        let presenter = ListChartsPresenter(
            analyticsChartFactory: analyticsChartFactory
        )

        let router = ListChartsRouter()

        view.output = presenter

        presenter.view = view
        presenter.router = router

        router.transitionHandler = view

        return view
    }
}
