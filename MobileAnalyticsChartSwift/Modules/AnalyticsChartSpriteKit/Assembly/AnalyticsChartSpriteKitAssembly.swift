import UIKit

/// VIPER Assembly of AnalyticsChartSpriteKit module.
public enum AnalyticsChartSpriteKitAssembly {

    /// Make AnalyticsChartSpriteKit module.
    public static func makeModule(
        inputData: AnalyticsChartSpriteKitModuleInputData
    ) -> (UIView, AnalyticsChartSpriteKitModuleInput) {
        let view = AnalyticsChartSpriteKitView()

        let analyticsYAxisLocalizationFactory = AnalyticsYAxisLocalizationFactoryImpl()
        let analyticsDefinitionFactory = AnalyticsDefinitionFactoryImpl()
        let presenter = AnalyticsChartSpriteKitPresenter(
            viewModels: inputData.viewModels,
            renderConfiguration: inputData.renderConfiguration,
            calculatorConfiguration: inputData.calculatorConfiguration,
            analyticsYAxisLocalizationFactory: analyticsYAxisLocalizationFactory,
            analyticsDefinitionFactory: analyticsDefinitionFactory
        )

        view.output = presenter

        presenter.view = view

        return (view, presenter)
    }
}
