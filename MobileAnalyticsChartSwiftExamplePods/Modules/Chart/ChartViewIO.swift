import UIKit

/// Chart view input
protocol ChartViewInput: class {
    func setTitle(_ title: String)
    func setChartView(_ chartView: UIView)
}

/// Chart view output
protocol ChartViewOutput: class {
    func setupView()
}
