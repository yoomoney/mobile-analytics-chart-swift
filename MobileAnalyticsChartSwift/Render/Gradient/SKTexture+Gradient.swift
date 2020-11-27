import SpriteKit

extension SKTexture {

    convenience init(
        size: CGSize,
        color1: CIColor,
        color2: CIColor,
        direction: GradientDirection = .up
    ) {
        let context = CIContext(options: nil)
        guard let filter = CIFilter(name: "CILinearGradient") else {
            self.init()
            return
        }
        var startVector: CIVector
        var endVector: CIVector

        filter.setDefaults()

        switch direction {
        case .up:
            startVector = CIVector(x: size.width * 0.5, y: 0)
            endVector = CIVector(x: size.width * 0.5, y: size.height)
        case .left:
            startVector = CIVector(x: size.width, y: size.height * 0.5)
            endVector = CIVector(x: 0, y: size.height * 0.5)
        case .upLeft:
            startVector = CIVector(x: size.width, y: 0)
            endVector = CIVector(x: 0, y: size.height)
        case .upRight:
            startVector = CIVector(x: 0, y: 0)
            endVector = CIVector(x: size.width, y: size.height)
        }

        filter.setValue(startVector, forKey: "inputPoint0")
        filter.setValue(endVector, forKey: "inputPoint1")
        filter.setValue(color1, forKey: "inputColor0")
        filter.setValue(color2, forKey: "inputColor1")

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        guard let outputImage = filter.outputImage,
              let image = context.createCGImage(outputImage, from: rect) else {
            self.init()
            return
        }
        self.init(cgImage: image)
    }
}
