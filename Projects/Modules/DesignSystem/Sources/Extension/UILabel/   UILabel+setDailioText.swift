import UIKit

public extension UILabel {
    func setDailioText(_ text: String, font: DailioFontStyle, color: UIColor) {
        self.text = text
        self.font = .dailioFont(font)
        self.textColor = color
    }
}
