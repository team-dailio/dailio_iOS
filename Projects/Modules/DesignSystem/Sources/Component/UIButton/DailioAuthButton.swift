import UIKit
import Then
import SnapKit

public final class DailioAuthButton: UIButton {
    public init(_ text: String) {
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.setTitleColor(.primary500, for: .normal)
        self.titleLabel?.font = .dailioFont(.body1)
        self.backgroundColor = .primary100
        self.layer.cornerRadius = 12
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
