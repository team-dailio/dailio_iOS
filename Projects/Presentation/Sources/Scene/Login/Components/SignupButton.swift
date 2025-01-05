import UIKit
import SnapKit
import Then

final class SignupButton: BaseView {
    private let signupLabel = UILabel().then {
        $0.setDailioText("아직 가입하지 않으셨나요?", font: .body3, color: .gray500)
    }
    internal let signupButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(UIColor.primary500, for: .normal)
        $0.titleLabel?.font = .dailioFont(.body3)
        $0.setUnderline()
    }

    override func addView() {
        [
            signupLabel,
            signupButton
        ].forEach { self.addSubview($0) }
    }
    override func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        signupLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        signupButton.snp.makeConstraints {
            $0.leading.equalTo(signupLabel.snp.trailing).offset(8)
            $0.height.equalTo(20)
        }
    }
}

extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}
