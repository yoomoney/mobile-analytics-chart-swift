//
//  AnalyticsView.swift
//  MobileAnalyticsChartSwift
//
//  Created by Rexford Machu on 8/19/21.
//

import SwiftUI
//Sample View Example to Witness Chart
struct AnalyticsView: View {
    @available(iOS 13.0.0, *)
    var body: some View {
        //The parameters are the points needed to plot the graph.
        let values: [CGFloat] = [4, 8, 15, 16, 23, 42,65,78,7,87,78,88,88,88,99,54,66,45,5,6,55,43,23,23,22,11,34,6,76,70,65,43]
        
        AnalyticsChart(xvalues: values, yvalues: values)
            .frame(width: 400, height: 400)
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    @available(iOS 13.0.0, *)
    static var previews: some View {
        AnalyticsView()
    }
}













//Creating variables for the View to be displayed.

//MARK:- Fade Animation
let fadeAnimation = ChartFadeAnimation(
    fadeOutColor: UIColor(white: 219 / 255, alpha: 1),
    fadeInColor: UIColor(white: 236 / 255, alpha: 1),
    startDuration: 0.2,
    fadeOutDuration: 0.6,
    fadeInDuration: 0.6
)


//MARK:- Function For Date Formatters.
// Creating date formatters
func dateTime(dateFormat : String)->DateFormatter{
    let dmmmyyyyDateFormatter = DateFormatter()
    dmmmyyyyDateFormatter.dateFormat = dateFormat
    return dmmmyyyyDateFormatter
}


// Creating a chart data
let calendar = Calendar.current //Calendar initially needed for date range
//Sample values for plotting chart view
let values: [CGFloat] = [4, 8, 15, 16, 23, 42,65,78,7,87,78,99,54,55,43,23,23,22,11,35,6,76,78,65,43]
let values2: [CGFloat] = [4, 5, 15, 20, 30, 42,7,78,7,87,78,99,54,66,45,43,23,23,22,11,35,6,76,78,65,]

//Calculating a date range
let dates = (0 ..< values.count).compactMap {
    calendar.date(byAdding: DateComponents(day: $0), to: Date())
}
//MARK:- Chart Data
let chartData = ChartData(
    values: values,
    dates: values2
)

//MARK:- Chart Path
let path = ChartPath(
    type: .horizontalQuadratic,
    color: #colorLiteral(red: 0.3051085472, green: 0.7460708022, blue: 0.3440477848, alpha: 1),
    minWidth: 1.0,
    maxWidth: 5.0,
    fadeAnimation: fadeAnimation
)
//MARK:- Chart Render Configuration
let chartRenderConfiguration = ChartRenderConfiguration(
    unit: .quantity,
    path: path,
    gradient: nil
)

//MARK:- analyticsChartSpriteKitViewModel
let analyticsChartSpriteKitViewModel = AnalyticsChartSpriteKitViewModel(
    data: chartData,
    configuration: chartRenderConfiguration
)

// Creating a range label configuration
//The dates at the top!
//MARK:- Chart Range Label
let rangeLabel = ChartRangeLabel(
    color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
    font: .systemFont(ofSize: 16, weight: .regular),
    dateFormatter: dateTime(dateFormat: "d MMM yyyy"),
    insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
)

// Creating a xAxis configuration
//MARK:- Chart Axis X

let xAxis = ChartXAxis(
    labelColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
    labelFont: .systemFont(ofSize: 11, weight: .regular),
    dateFormatter: dateTime(dateFormat: "d"),
    insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
    margins: UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5),
    zoomFactorLabels: 1.5
)

// Creating a yAxis configuration
//MARK:- Chart Axis Y


let yAxis = ChartYAxis(
    labelColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
    labelFont: .systemFont(ofSize: 11, weight: .regular),
    labelInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
    lineColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),
    lineWidth: 2
)

// Creating a zero line
//MARK:- Zero Line

let zeroLine = ChartZeroLine(
    color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
    width: 1
)

// Creating a gesture state configuration
//MARK:- Gesture State

let gestureState = ChartGestureState(
    swipeIsActive: true,
    pinchIsActive: true,
    handleIsActive: true
)

// Creating a animation configuration
//MARK:- Animation Configuration

let animation = ChartAnimation(
    redrawDuration: 0.1
)

// Creating a definition configuration
//MARK:- ChartDefinitionView

let definitionView = ChartDefinitionView(
    backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
    valueLabelFont: .systemFont(ofSize: 13),
    valueLabelColor: UIColor(white: 1, alpha: 1.0),
    dateLabelFont: .systemFont(ofSize: 11),
    dateLabelColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),
    dateFormatter: dateTime(dateFormat: "d MMM yyyy")
)

//MARK:- ChartDefinition
let definition = ChartDefinition(
    line: ChartDefinitionLine(color: #colorLiteral(red: 0.3051085472, green: 0.7460708022, blue: 0.3440477848, alpha: 1), width: 1),
    point: ChartDefinitionPoint(minRadius: 4, maxRadius: 10),
    view: definitionView,
    fadeAnimation: fadeAnimation
)

// Creating a chart sprite kit module input data
//The entire View
//MARK:- ChartViewModel
let chartViewModel = AnalyticsChartSpriteKitModuleInputData(
    viewModels: [analyticsChartSpriteKitViewModel],
    renderConfiguration: RenderConfiguration(
        rangeLabel: rangeLabel,
        xAxis: xAxis,
        yAxis: yAxis,
        zeroLine: zeroLine,
        gestureState: gestureState,
        animation: animation,
        definition: definition,
        backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        chartInsets: .zero,
        chartMargins: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
        fadeInDuration: 0.3,
        fadeOutDuration: 0.3
    ),
    calculatorConfiguration: CalculatorConfiguration(
        minStaticValue: nil,
        maxStaticValue: nil
    )
)

//MARK:- Analytics Chart View Struct.
struct AnalyticsChart: UIViewRepresentable {
    @available(iOS 13.0, *)
    typealias Context = UIViewRepresentableContext<Self>
    var yvalues : [CGFloat]? = [4, 8, 15, 16, 23, 42,65,78,7,87,78,88,88,88,99,54,66,45,5,6,55,43,23,23,22,11,35,6,76,78,65,43]
    var xvalues : [CGFloat]? = [4, 5, 15, 20, 30, 42,7,78,7,87,78,99,54,66,45,43,23,23,22,11,35,6,76,78,65,]
    init(xvalues : [CGFloat], yvalues : [CGFloat]) {
        self.yvalues = yvalues
        self.xvalues = xvalues
    }
    
    
    
    
    
    //MARK:- ChartView and ModuleInput.
    let (chartView, moduleInput) = AnalyticsChartSpriteKitAssembly.makeModule(
        inputData: chartViewModel
    )
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    @available(iOS 13.0, *)
    func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator, action:
                                            #selector(Coordinator.handleRefreshControl),
                                          for: .valueChanged)
        let childView = chartView
        childView.frame = CGRect(x: 13, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        
        control.addSubview(childView)
        return control
    }
    @available(iOS 13.0, *)
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
    
    //MARK:- Coordinator Class
    class Coordinator: NSObject {
        var control: AnalyticsChart
        init(_ control: AnalyticsChart) {
            self.control = control
        }
        @objc func handleRefreshControl(sender: UIRefreshControl) {
            sender.endRefreshing()
            print("Done")
        }
    }
}
