import SpriteKit
import UIKit

final public class AnalyticsChartSpriteKitView: UIView {

    // MARK: - VIPER

    var output: AnalyticsChartSpriteKitViewOutput!

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - UI properties

    private lazy var skView: SKView = {
        let view = SKView()
        view.shouldCullNonVisibleNodes = true
        view.ignoresSiblingOrder = true
        return view
    }()

    // MARK: - Managing the View

    private var isFirstLaunch = true

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        if isFirstLaunch {
            isFirstLaunch = false
            output.setupView()
        } else {
            output.redraw()
        }
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        output.traitCollectionDidChange()
    }

    // MARK: - Setup

    private func setup() {
        setupView()
        setupConstraints()
    }

    private func setupView() {
        [
            skView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    private func setupConstraints() {
        let constraints = [
            skView.topAnchor.constraint(equalTo: topAnchor),
            skView.bottomAnchor.constraint(equalTo: bottomAnchor),
            skView.leadingAnchor.constraint(equalTo: leadingAnchor),
            skView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - AnalyticsChartSpriteKitViewInput

extension AnalyticsChartSpriteKitView: AnalyticsChartSpriteKitViewInput {
    func setScene(scene: SKScene) {
        skView.presentScene(scene)
    }
}
