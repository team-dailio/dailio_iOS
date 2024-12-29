import UIKit
import Then
import SnapKit

public final class DailioAuthButton: UIButton {
    public init(_ text: String) {
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.tintColor = .white
        self.backgroundColor = .primary500
        self.layer.cornerRadius = 12
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.25
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
