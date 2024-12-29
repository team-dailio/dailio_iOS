import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class SignupViewController: BaseViewController<SignupViewModel> {
    private let logoImageView = UIImageView(image: .logo)
    private let signupLabel = UILabel().then {
        $0.setDailioText("회원가입", font: .heading3, color: .primary500)
    }
    private let signupPromptLabel = UILabel().then {
        $0.setDailioText(
            "회원가입을 통해 다양한 서비스를 즐겨보세요!",
            font: .body2,
            color: .gray500
        )
    }
    private let idAuthTextField = DailioAuthTectField("아이디", placeholder: "5자 ~ 10자 이상")
    private let pwdAuthTextField = DailioAuthTectField("비밀번호", placeholder: "영어, 숫자, 특수문자 포함 5자 이상")
    private let pwdConfirmAuthTextField = DailioAuthTectField("비밀번호 확인", placeholder: "비밀번호 재입력")
    private let emailAuthTextField = DailioAuthTectField("이메일", placeholder: "이메일 입력")
    private let signupButton = DailioAuthButton("가입하기")

    public override func addView() {
        [
            logoImageView,
            signupLabel,
            signupPromptLabel,
            idAuthTextField,
            pwdAuthTextField,
            pwdConfirmAuthTextField,
            emailAuthTextField,
            signupButton
        ].forEach { self.view.addSubview($0) }
    }
    public override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(64)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(80)
            $0.width.equalTo(92)
        }
        signupLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        signupPromptLabel.snp.makeConstraints {
            $0.top.equalTo(signupLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        idAuthTextField.snp.makeConstraints {
            $0.top.equalTo(signupPromptLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        pwdAuthTextField.snp.makeConstraints {
            $0.top.equalTo(idAuthTextField.authTextField.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview()
        }
        pwdConfirmAuthTextField.snp.makeConstraints {
            $0.top.equalTo(pwdAuthTextField.authTextField.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview()
        }
        emailAuthTextField.snp.makeConstraints {
            $0.top.equalTo(pwdConfirmAuthTextField.authTextField.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview()
        }
        signupButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(64)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
