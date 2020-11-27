import UIKit

final class ChartViewController: UIViewController {

    // MARK: - VIPER

    var output: ChartViewOutput!

    var chartView: UIView?

    // MARK: - Initializing

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Managing the View

    override func loadView() {
        view = UIView()
        view.backgroundColor = .cararra
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - ChartViewInput

extension ChartViewController: ChartViewInput {
    func setTitle(_ title: String) {
        navigationItem.title = title
    }

    func setChartView(_ chartView: UIView) {
        chartView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartView)
        let constraints = [
            chartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide
                                            .topAnchor),
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
