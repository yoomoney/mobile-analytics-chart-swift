import UIKit

class HorizontalQuadraticPath: UIBezierPath {
    convenience init(
        points: [CGPoint],
        phaseY: CGFloat = 1.0
    ) {
        self.init()
        guard points.isEmpty == false else { return }

        var prev = points[0]
        var cur = prev

        move(to: CGPoint(x: cur.x, y: cur.y * phaseY))

        for j in 0 ..< points.count {
            prev = cur
            cur = points[j]

            let cpx = prev.x + (cur.x - prev.x) / 2.0
            addCurve(
                to: CGPoint(
                    x: cur.x,
                    y: cur.y * phaseY),
                controlPoint1: CGPoint(
                    x: cpx,
                    y: prev.y * phaseY),
                controlPoint2: CGPoint(
                    x: cpx,
                    y: cur.y * phaseY)
            )
        }
    }
}
