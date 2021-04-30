import CoreGraphics
import MobileAnalyticsChartSwift

final class ChartPresenter {

    // MARK: - VIPER

    weak var view: ChartViewInput?

    weak var analyticsChartSpriteKitModuleInput: AnalyticsChartSpriteKitModuleInput?

    private let analyticsChartViewModel: AnalyticsChartViewModel

    init(analyticsChartViewModel: AnalyticsChartViewModel) {
        self.analyticsChartViewModel = analyticsChartViewModel
    }
}

extension ChartPresenter: ChartViewOutput {
    func setupView() {
        let (chartView, moduleInput) = AnalyticsChartSpriteKitAssembly.makeModule(
            inputData: analyticsChartViewModel.data,
            moduleOutput: self
        )

        analyticsChartSpriteKitModuleInput = moduleInput

        view?.setTitle(analyticsChartViewModel.title)
        view?.setChartView(chartView)
    }
}

extension ChartPresenter: AnalyticsChartSpriteKitModuleOutput {
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
