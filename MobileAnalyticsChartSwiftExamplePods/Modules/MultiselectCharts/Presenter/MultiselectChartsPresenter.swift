import MobileAnalyticsChartSwift
import UIKit

final class MultiselectChartsPresenter {

    // MARK: - VIPER

    weak var view: MultiselectChartsViewInput?

    weak var analyticsChartSpriteKitModuleInput: AnalyticsChartSpriteKitModuleInput?

    private let analyticsChartViewModel: AnalyticsChartViewModel

    init(analyticsChartViewModel: AnalyticsChartViewModel) {
        self.analyticsChartViewModel = analyticsChartViewModel
        self.selectedRows = Array(repeating: true, count: analyticsChartViewModel.data.viewModels.count)
    }

    // MARK: - Stored properties

    private var selectedRows: [Bool] = []
}

extension MultiselectChartsPresenter: MultiselectChartsViewOutput {
    func setupView() {
        let (chartView, moduleInput) = AnalyticsChartSpriteKitAssembly.makeModule(
            inputData: analyticsChartViewModel.data
        )

        analyticsChartSpriteKitModuleInput = moduleInput

        view?.setTitle(analyticsChartViewModel.title)
        view?.reloadData()
        view?.setChartView(chartView)
    }

    func numberOfRows() -> Int {
        analyticsChartViewModel.data.viewModels.count
    }

    func colorForRow(at indexPath: IndexPath) -> UIColor {
        analyticsChartViewModel.data.viewModels[indexPath.row].configuration.path.color
    }

    func isSelectedRow(at indexPath: IndexPath) -> Bool {
        selectedRows[indexPath.row]
    }

    func didSelect(at indexPath: IndexPath) {
        selectedRows[indexPath.row].toggle()
        redrawCharts()
    }

    func didDeselect(at indexPath: IndexPath) {
        selectedRows[indexPath.row].toggle()
        redrawCharts()
    }

    private func redrawCharts() {
        let onlySelectedRows = selectedRows.enumerated().filter { $0.element }
        var viewModels: [AnalyticsChartSpriteKitViewModel] = []
        for item in analyticsChartViewModel.data.viewModels.enumerated() {
            if onlySelectedRows.contains(where: { $0.offset == item.offset }) {
                viewModels.append(item.element)
            }
        }
        analyticsChartSpriteKitModuleInput?.setChartViewModels(
            viewModels: viewModels,
            silent: true
        )
    }
}

extension MultiselectChartsPresenter: AnalyticsChartSpriteKitModuleOutput {
    func didChangeRangeValue(
        rangeValue: RangeValue<CGFloat>
    ) {
        print(#function, rangeValue)
    }

    func didHandleLongPress() {
        print(#function)
    }

    func didHandlePan(
        deltaLocation: CGFloat
    ) {
        print(#function, deltaLocation)
    }

    func didHandlePinch(
        scale: CGFloat
    ) {
        print(#function, scale)
    }
}
