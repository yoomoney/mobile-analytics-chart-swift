import MobileAnalyticsChartSwift

final class CustomChartPresenter {

    // MARK: - VIPER

    weak var view: CustomChartViewInput?

    weak var analyticsChartSpriteKitModuleInput: AnalyticsChartSpriteKitModuleInput?

    private let analyticsChartViewModel: AnalyticsChartViewModel

    init(analyticsChartViewModel: AnalyticsChartViewModel) {
        self.analyticsChartViewModel = analyticsChartViewModel
    }

    // MARK: - Stored properties

    private var currentChartIndex = 0
}

extension CustomChartPresenter: CustomChartViewOutput {
    func setupView() {
        let (chartView, moduleInput) = AnalyticsChartSpriteKitAssembly.makeModule(
            inputData: analyticsChartViewModel.data
        )

        analyticsChartSpriteKitModuleInput = moduleInput

        view?.setTitle(analyticsChartViewModel.title)
        view?.setChartView(chartView)
    }

    func didPressSetChartButton() {
        currentChartIndex = abs(currentChartIndex - 1)
        analyticsChartSpriteKitModuleInput?.setChartViewModels(
            viewModels: [
                analyticsChartViewModel.data.viewModels[currentChartIndex],
            ],
            silent: false
        )
    }

    func didPressSetChartSilentButton() {
        currentChartIndex = abs(currentChartIndex - 1)
        analyticsChartSpriteKitModuleInput?.setChartViewModels(
            viewModels: [
                analyticsChartViewModel.data.viewModels[currentChartIndex],
            ],
            silent: true
        )
    }

    func didPressSetLoadingStateButton() {
        analyticsChartSpriteKitModuleInput?.setChartLoadingState()
    }

    func didPressSetIdleStateButton() {
        analyticsChartSpriteKitModuleInput?.setChartIdleState()
    }
}
