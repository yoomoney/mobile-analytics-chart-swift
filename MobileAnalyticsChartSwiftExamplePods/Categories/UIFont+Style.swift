import UIKit

extension UIFont {
    private class _FontsCache {
        init() {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(contentSizeCategoryDidChangeNotification(_:)),
                name: UIContentSizeCategory.didChangeNotification,
                object: nil
            )
        }

        deinit {
            NotificationCenter.default.removeObserver(self)
        }

        static let shared = _FontsCache()

        var cache = NSCache<NSString, UIFont>()

        @objc
        private func contentSizeCategoryDidChangeNotification(_ notification: Notification) {
            cache.removeAllObjects()
        }
    }

    static var dynamicCaption1: UIFont {
        return UIFont.makeFont(style: .footnote, face: "Regular")
    }

    static var dynamicCaption2: UIFont {
        return UIFont.makeFont(style: .caption2, face: "Regular")
    }

    private static func makeFont(style: UIFont.TextStyle, face: String) -> UIFont {
        let cacheKey = NSString(string: style.rawValue + face)
        if let font = _FontsCache.shared.cache.object(forKey: cacheKey) {
            return font
        } else {
            var descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
            let size = descriptor.fontAttributes[UIFontDescriptor.AttributeName.size] as? Float ?? 0
            descriptor = UIFontDescriptor()
            let font = UIFont.systemFont(ofSize: CGFloat(size))
            descriptor = descriptor.withFamily(font.familyName)
            descriptor = descriptor.withSize(CGFloat(size))
            descriptor = descriptor.withFace(face)
            let resultFont = UIFont(descriptor: descriptor, size: 0)
            _FontsCache.shared.cache.setObject(resultFont, forKey: cacheKey)
            return resultFont
        }
    }
}
