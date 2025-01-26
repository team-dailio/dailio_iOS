import UIKit
import Then
import SnapKit

public final class DailioConfirmButton: UIButton {
    public init(_ text: String) {
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.setTitleColor(.primary500, for: .normal)
        self.titleLabel?.font = .dailioFont(.body1)
        self.backgroundColor = .white100
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.primary500.cgColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
