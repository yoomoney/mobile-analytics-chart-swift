import MobileAnalyticsChartSwift
import UIKit

/// MultiselectCharts view input
protocol MultiselectChartsViewInput: class {
    func reloadData()
    func setTitle(_ title: String)
    func setChartView(_ chartView: UIView)
}

/// MultiselectCharts view output
protocol MultiselectChartsViewOutput: class {
    func setupView()
    func numberOfRows() -> Int
    func colorForRow(at indexPath: IndexPath) -> UIColor
    func isSelectedRow(at indexPath: IndexPath) -> Bool
    func didSelect(at indexPath: IndexPath)
    func didDeselect(at indexPath: IndexPath)
}
