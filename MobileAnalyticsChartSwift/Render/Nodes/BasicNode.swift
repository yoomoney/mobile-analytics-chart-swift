import SpriteKit

public class BasicNode: SKShapeNode {

    override init() {
        super.init()
        blendMode = .replace
        isAntialiased = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
