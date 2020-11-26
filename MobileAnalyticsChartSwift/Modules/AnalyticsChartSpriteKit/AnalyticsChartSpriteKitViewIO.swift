import SpriteKit

/// AnalyticsChartSpriteKit view input
protocol AnalyticsChartSpriteKitViewInput: class {
    func setScene(scene: SKScene)
}

/// AnalyticsChartSpriteKit view output
protocol AnalyticsChartSpriteKitViewOutput: class {
    func setupView()

    func redraw()

    func traitCollectionDidChange()
}
