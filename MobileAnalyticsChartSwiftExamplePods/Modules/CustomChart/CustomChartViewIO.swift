import UIKit

/// CustomChart view input
protocol CustomChartViewInput: class {
    func setTitle(_ title: String)
    func setChartView(_ chartView: UIView)
}

/// CustomChart view output
protocol CustomChartViewOutput: class {
    func setupView()
    func didPressSetChartButton()
    func didPressSetChartSilentButton()
    func didPressSetLoadingStateButton()
    func didPressSetIdleStateButton()
}
