import SpriteKit

public class SquareNode: BasicNode {

    override init() {
        super.init()
        lineCap = .square
        lineJoin = .miter
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
