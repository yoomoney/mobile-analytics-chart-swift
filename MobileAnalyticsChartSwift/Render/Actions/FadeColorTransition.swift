import SpriteKit

extension SKAction {
    static func fadeAction(
        startAction: SKAction,
        fadeOutAction: SKAction,
        fadeInAction: SKAction
    ) -> SKAction {
        let sequenceAction = SKAction.sequence([
            fadeOutAction,
            fadeInAction,
        ])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        return SKAction.sequence([
            startAction,
            repeatAction,
        ])
    }
}
