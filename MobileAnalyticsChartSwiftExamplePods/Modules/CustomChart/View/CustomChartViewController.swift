import UIKit

final class CustomChartViewController: UIViewController {

    // MARK: - VIPER

    var output: CustomChartViewOutput!

    // MARK: - UI properties

    private lazy var chartView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Space.double
        return view
    }()

    private lazy var setChartStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = Space.double
        return view
    }()

    private lazy var setStateStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = Space.double
        return view
    }()

    private lazy var setChartButton: UIButton = {
        let view = UIButton()
        view.setTitle("Set chart", for: .normal)
        view.setTitleColor(.dodgerBlue, for: .normal)
        view.addTarget(self, action: #selector(didPressSetChartButton), for: .touchUpInside)
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.dodgerBlue.cgColor
        return view
    }()

    private lazy var setChartSilentButton: UIButton = {
        let view = UIButton()
        view.setTitle("Set chart silent", for: .normal)
        view.setTitleColor(.dodgerBlue, for: .normal)
        view.addTarget(self, action: #selector(didPressSetChartSilentButton), for: .touchUpInside)
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.dodgerBlue.cgColor
        return view
    }()

    private lazy var setLoadingStateButton: UIButton = {
        let view = UIButton()
        view.setTitle("Set loading state", for: .normal)
        view.setTitleColor(.dodgerBlue, for: .normal)
        view.addTarget(self, action: #selector(didPressSetLoadingStateButton), for: .touchUpInside)
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.dodgerBlue.cgColor
        return view
    }()

    private lazy var setIdleStateButton: UIButton = {
        let view = UIButton()
        view.setTitle("Set idle state", for: .normal)
        view.setTitleColor(.dodgerBlue, for: .normal)
        view.addTarget(self, action: #selector(didPressSetIdleStateButton), for: .touchUpInside)
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.dodgerBlue.cgColor
        return view
    }()

    // MARK: - Managing the View

    override func loadView() {
        view = UIView()
        view.backgroundColor = .cararra
        setupView()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.setupView()
    }

    // MARK: - Setup

    private func setupView() {
        [
            chartView,
            mainStackView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        [
            setChartStackView,
            setStateStackView,
        ].forEach(mainStackView.addArrangedSubview)

        [
            setChartButton,
            setChartSilentButton,
        ].forEach(setChartStackView.addArrangedSubview)

        [
            setLoadingStateButton,
            setIdleStateButton,
        ].forEach(setStateStackView.addArrangedSubview)
    }

    private func setupConstraints() {
        let constraints = [
            chartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            mainStackView.topAnchor.constraint(equalTo: chartView.bottomAnchor,
                                               constant: Space.double),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: Space.double),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -Space.double),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -Space.double),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Actions

    @objc
    private func didPressSetChartButton() {
        output.didPressSetChartButton()
    }

    @objc
    private func didPressSetChartSilentButton() {
        output.didPressSetChartSilentButton()
    }

    @objc
    private func didPressSetLoadingStateButton() {
        output.didPressSetLoadingStateButton()
    }

    @objc
    private func didPressSetIdleStateButton() {
        output.didPressSetIdleStateButton()
    }
}

// MARK: - CustomChartViewInput

extension CustomChartViewController: CustomChartViewInput {
    func setTitle(_ title: String) {
        navigationItem.title = title
    }

    func setChartView(_ chartView: UIView) {
        chartView.translatesAutoresizingMaskIntoConstraints = false
        self.chartView.addSubview(chartView)
        let constraints = [
            chartView.topAnchor.constraint(equalTo: self.chartView.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: self.chartView.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: self.chartView.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: self.chartView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
