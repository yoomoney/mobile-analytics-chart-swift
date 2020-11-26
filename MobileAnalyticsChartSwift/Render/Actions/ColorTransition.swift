import SpriteKit

extension SKAction {
    static func strokeColorTransitionAction(
        fromColor: UIColor,
        toColor: UIColor,
        duration: TimeInterval = 0.5
    ) -> SKAction {
        return SKAction.customAction(withDuration: duration) { (node: SKNode, elapsedTime: CGFloat) in
            guard let shapeNode = node as? SKShapeNode else { return }

            let transColor = makeTransColor(
                elapsedTime: elapsedTime,
                duration: duration,
                fromColor: fromColor,
                toColor: toColor
            )

            shapeNode.strokeColor = transColor
        }
    }

    static func gradientColorTransitionAction(
        fromColor: UIColor,
        toColor: UIColor,
        duration: TimeInterval = 0.5,
        direction: GradientDirection = .up
    ) -> SKAction {
        return SKAction.customAction(withDuration: duration) { (node: SKNode, elapsedTime: CGFloat) in
            guard let spriteNode = node as? SKSpriteNode else { return }

            let transColor = makeTransColor(
                elapsedTime: elapsedTime,
                duration: duration,
                fromColor: fromColor,
                toColor: toColor
            )
            let size = spriteNode.size
            let textureSize = CGSize(
                width: size.width / 2,
                height: size.height / 2
            )
            let texture = SKTexture(
                size: textureSize,
                color1: CIColor(color: transColor.withAlphaComponent(0.0)),
                color2: CIColor(color: transColor),
                direction: direction
            )
            texture.filteringMode = .linear
            spriteNode.texture = texture
        }
    }
}

private func makeTransColor(
    elapsedTime: CGFloat,
    duration: TimeInterval,
    fromColor: UIColor,
    toColor: UIColor
) -> UIColor {
    let fraction = cubicEaseOut(CGFloat(elapsedTime / CGFloat(duration)))
    let startColorComponents = fromColor.toComponents()
    let endColorComponents = toColor.toComponents()
    return UIColor(
        red: lerp(a: startColorComponents.red, b: endColorComponents.red, fraction: fraction),
        green: lerp(a: startColorComponents.green, b: endColorComponents.green, fraction: fraction),
        blue: lerp(a: startColorComponents.blue, b: endColorComponents.blue, fraction: fraction),
        alpha: lerp(a: startColorComponents.alpha, b: endColorComponents.alpha, fraction: fraction)
    )
}

private func lerp(
    a: CGFloat,
    b: CGFloat,
    fraction: CGFloat
) -> CGFloat {
    return (b - a) * fraction + a
}

private struct ColorComponents {
    var red = CGFloat(0)
    var green = CGFloat(0)
    var blue = CGFloat(0)
    var alpha = CGFloat(0)
}

private extension UIColor {
    func toComponents() -> ColorComponents {
        var components = ColorComponents()
        getRed(
            &components.red,
            green: &components.green,
            blue: &components.blue,
            alpha: &components.alpha
        )
        return components
    }
}
