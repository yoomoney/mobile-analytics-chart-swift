import UIKit

extension UIColor {

    static let radicalRed = UIColor(red: 1, green: 51 / 255, blue: 102 / 255, alpha: 1)
    static let dodgerBlue = UIColor(red: 51 / 255, green: 102 / 255, blue: 1, alpha: 1)
    static let heliotrope = UIColor(red: 153 / 255, green: 102 / 255, blue: 1, alpha: 1)
    static let baliHai = UIColor(red: 134 / 255, green: 149 / 255, blue: 175 / 255, alpha: 1)

    static var border: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor(white: 1, alpha: 0.05)
                } else {
                    return UIColor(white: 0, alpha: 0.05)
                }
            }
        } else {
            return UIColor(white: 0, alpha: 0.05)
        }
    }()

    static var borderZeroLine: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor(white: 1, alpha: 0.1)
                } else {
                    return UIColor(white: 0, alpha: 0.1)
                }
            }
        } else {
            return UIColor(white: 0, alpha: 0.21)
        }
    }()

    static var alto: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor(white: 219 / 255, alpha: 1)
                } else {
                    return UIColor(white: 219 / 255, alpha: 1)
                }
            }
        } else {
            return UIColor(white: 219 / 255, alpha: 1)
        }
    }()

    static var gallery: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor(white: 236 / 255, alpha: 1)
                } else {
                    return UIColor(white: 236 / 255, alpha: 1)
                }
            }
        } else {
            return UIColor(white: 236 / 255, alpha: 1)
        }
    }()

    static var cararra: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 28 / 255, green: 31 / 255, blue: 33 / 255, alpha: 1)
                } else {
                    return UIColor(white: 247 / 255, alpha: 1)
                }
            }
        } else {
            return UIColor(white: 247 / 255, alpha: 1)
        }
    }()

    static var doveGray: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor(white: 165 / 255, alpha: 1)
                } else {
                    return UIColor(white: 102 / 255, alpha: 1)
                }
            }
        } else {
            return UIColor(white: 102 / 255, alpha: 1)
        }
    }()

    static var ghost: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor(white: 97 / 255, alpha: 1)
                } else {
                    return UIColor(white: 179 / 255, alpha: 1)
                }
            }
        } else {
            return UIColor(white: 179 / 255, alpha: 1)
        }
    }()
}
