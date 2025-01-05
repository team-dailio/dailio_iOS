import UIKit

public extension UIFont {
    static func dailioFont(_ font: DailioFontStyle) -> UIFont {
        font.uiFont()
    }
}

extension DailioFontStyle {
    func lineHeight() -> CGFloat {
        switch self {
        case .heading1:
            return 60
        case .heading2:
            return 54
        case .heading3:
            return 48
        case .heading4:
            return 40
        case .heading5:
            return 36
        case .heading6:
            return 28

        case .body1, .body2:
            return 24
        case .body3, .body4:
            return 20

        case .caption1, .caption2:
            return 18
        case .caption3, .caption4:
            return 16
        }
    }

    func uiFont() -> UIFont {
        let notoSans = DesignSystemFontFamily.NotoSans.self

        switch self {
        case .heading1, .heading2, .heading3:
            return notoSans.bold.font(size: self.size())
        case .heading4, .heading5, .heading6, .body1, .body3, .caption1, .caption3:
            return notoSans.medium.font(size: self.size())
        case .body2, .body4, .caption2, .caption4:
            return notoSans.regular.font(size: self.size())
        }
    }

    func size() -> CGFloat {
        switch self {
        case .heading1:
            return 40
        case .heading2:
            return 36
        case .heading3:
            return 32
        case .heading4:
            return 28
        case .heading5:
            return 24
        case .heading6:
            return 20

        case .body1, .body2:
            return 16
        case .body3, .body4:
            return 14

        case .caption1, .caption2:
            return 12
        case .caption3, .caption4:
            return 10
        }
    }
}
