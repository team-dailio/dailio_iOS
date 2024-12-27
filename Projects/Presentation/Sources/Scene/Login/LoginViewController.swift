import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class LoginViewController: BaseViewController<LoginViewModel> {
    private let logoImageView = UIImageView(image: .logo)
    private let loginLabel = UILabel().then {
        $0.setDailioText("로그인", font: .heading3, color: .primary500)
    }
    private let loginPromptLabel = UILabel().then {
        $0.setDailioText(
            "로그인하여 다양한 기능을 사용해보세요.",
            font: .body2,
            color: .gray500
        )
    }
    private let idAuthTextField = DailioAuthTectField("아이디", placeholder: "5자 ~ 10자 이상")
    private let pwdAuthTextField = DailioAuthTectField("비밀번호", placeholder: "영어, 숫자, 특수문자 포함 5자 이상")
    private let signupButton = SignupButton()
    private let loginButton = DailioButton("로그인", textColor: .primary100, buttonColor: .primary500)

    public override func addView() {
        [
            logoImageView,
            loginLabel,
            loginPromptLabel,
            idAuthTextField,
            pwdAuthTextField,
            signupButton,
            loginButton
        ].forEach { self.view.addSubview($0) }
    }

    public override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(64)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(80)
            $0.width.equalTo(92)
        }
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        loginPromptLabel.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        idAuthTextField.snp.makeConstraints {
            $0.top.equalTo(loginPromptLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        pwdAuthTextField.snp.makeConstraints {
            $0.top.equalTo(idAuthTextField.authTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        signupButton.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.top).offset(-8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.equalTo(216)
        }
        loginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(64)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
