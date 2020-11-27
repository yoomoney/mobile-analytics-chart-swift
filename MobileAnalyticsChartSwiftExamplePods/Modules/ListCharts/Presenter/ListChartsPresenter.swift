import Foundation
import MobileAnalyticsChartSwift

final class ListChartsPresenter {

    // MARK: - VIPER

    var router: ListChartsRouterInput!

    weak var view: ListChartsViewInput?

    private let analyticsChartFactory: AnalyticsChartFactory

    init(analyticsChartFactory: AnalyticsChartFactory) {
        self.analyticsChartFactory = analyticsChartFactory
    }

    // MARK: - Stored data

    private var viewModels: [AnalyticsChartViewModel] = []
}

extension ListChartsPresenter: ListChartsViewOutput {
    func setupView() {
        viewModels = analyticsChartFactory.makeViewModels()
        view?.reloadData()
    }

    func numberOfRows() -> Int {
        viewModels.count
    }

    func titleForRow(at indexPath: IndexPath) -> String {
        viewModels[indexPath.row].title
    }

    func didSelect(at indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        switch viewModel.type {
        case .default:
            router.openChartModule(inputData: viewModel)
        case .custom:
            router.openCustomChartModule(inputData: viewModel)
        case .multiselect:
            router.openMultiselectChartsModule(inputData: viewModel)
        }
    }
}
