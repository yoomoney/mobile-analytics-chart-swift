import MobileAnalyticsChartSwift
import UIKit

final class MultiselectChartsViewController: UIViewController {

    // MARK: - VIPER

    var output: MultiselectChartsViewOutput!

    // MARK: - UI properties

    private lazy var chartView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(
            UITableViewCell.self,
            forCellReuseIdentifier: Constants.defaultCellIdentifier
        )
        view.allowsMultipleSelection = true
        view.tableFooterView = UIView()
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
            tableView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        let constraints = [
            chartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: chartView.bottomAnchor,
                                           constant: Space.double),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -Space.double),
            tableView.heightAnchor.constraint(equalToConstant: 200),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - MultiselectChartsViewInput

extension MultiselectChartsViewController: MultiselectChartsViewInput {
    func reloadData() {
        tableView.reloadData()
        for i in 0 ..< output.numberOfRows() {
            let indexPath = IndexPath(row: i, section: 0)
            if output.isSelectedRow(at: indexPath) {
                tableView.selectRow(
                    at: indexPath,
                    animated: true,
                    scrollPosition: .none
                )
            }
        }
    }

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

// MARK: - UITableViewDataSource

extension MultiselectChartsViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        output.numberOfRows()
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.defaultCellIdentifier,
            for: indexPath
        )
        cell.textLabel?.text = "Chart №\(indexPath.row)"
        cell.textLabel?.textColor = output.colorForRow(at: indexPath)
        cell.tintColor = output.colorForRow(at: indexPath)
        cell.selectionStyle = .none
        if output.isSelectedRow(at: indexPath) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MultiselectChartsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        output.didSelect(at: indexPath)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }

    func tableView(
        _ tableView: UITableView,
        didDeselectRowAt indexPath: IndexPath
    ) {
        output.didDeselect(at: indexPath)
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

private extension MultiselectChartsViewController {
    enum Constants {
        static let defaultCellIdentifier = "defaultCellIdentifier"
    }
}
