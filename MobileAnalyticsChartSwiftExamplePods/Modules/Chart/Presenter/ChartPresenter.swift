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
            inputData: analyticsChartViewModel.data
        )

        analyticsChartSpriteKitModuleInput = moduleInput

        view?.setTitle(analyticsChartViewModel.title)
        view?.setChartView(chartView)
    }
}
