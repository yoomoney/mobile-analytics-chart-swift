import UIKit

final class ListChartsRouter {
    weak var transitionHandler: UIViewController?
}

// MARK: -

extension ListChartsRouter: ListChartsRouterInput {
    func openChartModule(
        inputData: AnalyticsChartViewModel
    ) {
        let viewController = ChartAssembly.makeModule(
            inputData: inputData
        )
        transitionHandler?.navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }

    func openCustomChartModule(
        inputData: AnalyticsChartViewModel
    ) {
        let viewController = CustomChartAssembly.makeModule(
            inputData: inputData
        )
        transitionHandler?.navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }

    func openMultiselectChartsModule(
        inputData: AnalyticsChartViewModel
    ) {
        let viewController = MultiselectChartsAssembly.makeModule(
            inputData: inputData
        )
        transitionHandler?.navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
}
