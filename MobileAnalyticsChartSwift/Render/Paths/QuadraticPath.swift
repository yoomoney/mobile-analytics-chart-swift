import UIKit

class QuadraticPath: UIBezierPath {
    convenience init(
        points: [CGPoint],
        phaseY: CGFloat = 1.0,
        intensity: CGFloat = 0.2
    ) {
        self.init()
        guard points.count > 1 else { return }

        var prevDx: CGFloat = 0.0
        var prevDy: CGFloat = 0.0
        var curDx: CGFloat = 0.0
        var curDy: CGFloat = 0.0

        var prevPrev: CGPoint = points[0]
        var prev: CGPoint = points[0]
        var cur: CGPoint = points[0]
        var next: CGPoint = points[0]
        var nextIndex: Int = -1

        move(to: CGPoint(x: cur.x, y: cur.y * phaseY))

        for j in 0..<points.count {
            prevPrev = prev
            prev = cur
            cur = nextIndex == j ? next : points[j]

            nextIndex = j + 1 < points.count ? j + 1 : j
            next = points[nextIndex]

            prevDx = (cur.x - prevPrev.x) * intensity
            prevDy = (cur.y - prevPrev.y) * intensity
            curDx = (next.x - prev.x) * intensity
            curDy = (next.y - prev.y) * intensity

            addCurve(
                to: CGPoint(
                    x: cur.x,
                    y: cur.y * phaseY),
                controlPoint1: CGPoint(
                    x: prev.x + prevDx,
                    y: (prev.y + prevDy) * phaseY),
                controlPoint2: CGPoint(
                    x: cur.x - curDx,
                    y: (cur.y - curDy) * phaseY)
            )
        }
    }
}
