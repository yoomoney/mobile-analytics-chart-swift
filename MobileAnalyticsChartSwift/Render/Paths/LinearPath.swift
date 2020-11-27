import UIKit

class LinearPath: UIBezierPath {
    convenience init(
        points: [CGPoint]
    ) {
        self.init()
        guard points.count > 1 else { return }

        move(to: points[0])
        points[1 ..< points.endIndex].forEach { addLine(to: $0) }
    }
}
