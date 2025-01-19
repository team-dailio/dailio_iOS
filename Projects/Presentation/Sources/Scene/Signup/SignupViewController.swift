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
    private let idAuthTextField = DailioAuthTextField(
        "아이디",
        placeholder: "5자 ~ 10자 이상"
    )
    private let pwdAuthTextField = DailioAuthTextField(
        "비밀번호",
        placeholder: "영어, 숫자, 특수문자 포함 5자 이상"
    ).then {
        $0.authTextField.isSecureTextEntry = true
    }
    private let pwdConfirmAuthTextField = DailioAuthTextField(
        "비밀번호 확인",
        placeholder: "비밀번호 재입력"
    ).then {
        $0.authTextField.isSecureTextEntry = true
    }
    private let emailAuthTextField = DailioAuthTextField(
        "이메일",
        placeholder: "이메일 입력"
    )
    private let signupButton = DailioAuthButton("가입하기")

    public override func attribute() {
        super.attribute()
        self.navigationItem.hidesBackButton = true
    }
    public override func bind() {
        let input = SignupViewModel.Input(
            idText: idAuthTextField.authTextField.rx.text.orEmpty.asDriver(),
            passwordText: pwdAuthTextField.authTextField.rx.text.orEmpty.asDriver(),
            passwordConfirmText: pwdConfirmAuthTextField.authTextField.rx.text.orEmpty.asDriver(),
            emailText: emailAuthTextField.authTextField.rx.text.orEmpty.asDriver(),
            signupButtonDidTap: signupButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input: input)

        output.isButtonEnabled
            .drive(onNext: { [weak self] isEnabled in
                guard let self = self else { return }

                self.signupButton.isEnabled = isEnabled
                self.signupButton.backgroundColor = isEnabled ? UIColor.primary500 : UIColor.primary100
                self.signupButton.setTitleColor(isEnabled ? UIColor.primary100 : UIColor.primary500, for: .normal)
                self.signupButton.alpha = isEnabled ? 1 : 0.4
            })
            .disposed(by: disposeBag)

        output.idErrorDescription
            .asObservable()
            .bind { description in
                self.idAuthTextField.setDescription(description)
            }
            .disposed(by: disposeBag)
        output.passwordErrorDescription
            .asObservable()
            .bind { description in
                self.pwdAuthTextField.setDescription(description)
            }
            .disposed(by: disposeBag)
        output.passwordConfirmErrorDescription
            .asObservable()
            .bind { description in
                self.pwdConfirmAuthTextField.setDescription(description)
            }
            .disposed(by: disposeBag)
        output.emailErrorDescription
            .asObservable()
            .bind { description in
                self.emailAuthTextField.setDescription(description)
            }
            .disposed(by: disposeBag)
    }
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
            $0.top.equalTo(idAuthTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }
        pwdConfirmAuthTextField.snp.makeConstraints {
            $0.top.equalTo(pwdAuthTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }
        emailAuthTextField.snp.makeConstraints {
            $0.top.equalTo(pwdConfirmAuthTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }
        signupButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(64)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
