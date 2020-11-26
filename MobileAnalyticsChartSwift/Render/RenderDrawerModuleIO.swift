import CoreGraphics

public protocol RenderDrawerModuleInput: class {

    func setConfiguration(_ configuration: RenderConfiguration)

    func setChartsConfiguration(_ chartsConfiguration: [ChartRenderConfiguration])

    func setCalculator(_ calculator: Calculator)

    func startFade()

    func stopFade()

    func fadeInChart()

    func fadeOutChart()
}

public protocol RenderDrawerModuleOutput: class {
    func didChangeRangeValue(
        rangeValue: RangeValue<CGFloat>
    )

    func didHandleLongPress()

    func didHandlePan(
        deltaLocation: CGFloat
    )

    func didHandlePinch(
        scale: CGFloat
    )
}
