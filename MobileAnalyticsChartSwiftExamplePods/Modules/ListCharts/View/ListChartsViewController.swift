import UIKit

final class ListChartsViewController: UIViewController {

    // MARK: - VIPER

    var output: ListChartsViewOutput!

    // MARK: - Initializing

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - UI properties

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(
            UITableViewCell.self,
            forCellReuseIdentifier: Constants.defaultCellIdentifier
        )
        view.tableFooterView = UIView()
        return view
    }()

    // MARK: - Managing the View

    override func loadView() {
        view = UIView()
        setupView()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.setupView()
    }

    // MARK: - Setup

    private func setup() {
        navigationItem.title = "Chart list"
    }

    private func setupView() {
        [
            tableView,
        ].forEach(view.addSubview)
    }

    private func setupConstraints() {
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - ListChartsViewInput

extension ListChartsViewController: ListChartsViewInput {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ListChartsViewController: UITableViewDataSource {
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
        cell.textLabel?.text = output.titleForRow(at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListChartsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        output.didSelect(at: indexPath)
    }
}

private extension ListChartsViewController {
    enum Constants {
        static let defaultCellIdentifier = "defaultCellIdentifier"
    }
}
