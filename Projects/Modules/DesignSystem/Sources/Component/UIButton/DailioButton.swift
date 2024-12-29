import UIKit
import Then
import SnapKit

public final class DailioButton: UIButton {
    public init(_ text: String, textColor: UIColor, buttonColor: UIColor) {
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.tintColor = textColor
        self.backgroundColor = buttonColor
        self.layer.cornerRadius = 12
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.25
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
