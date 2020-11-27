import SpriteKit

public class RoundNode: BasicNode {

    override init() {
        super.init()
        lineCap = .round
        lineJoin = .round
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
