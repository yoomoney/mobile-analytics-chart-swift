import Foundation

/// ListCharts view input
protocol ListChartsViewInput: class {
    func reloadData()
}

/// ListCharts view output
protocol ListChartsViewOutput: class {
    func setupView()
    func numberOfRows() -> Int
    func titleForRow(at indexPath: IndexPath) -> String
    func didSelect(at indexPath: IndexPath)
}
