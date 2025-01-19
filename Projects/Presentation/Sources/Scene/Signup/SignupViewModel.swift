import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain
import DesignSystem

public class SignupViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()

    private func isValidPassword(_ password: String) -> Bool {
        let passwordExpression = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{5,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordExpression)
        return passwordPredicate.evaluate(with: password)
    }
    private func isValidEmail(_ email: String) -> Bool {
        let emailExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailExpression)
        return emailPredicate.evaluate(with: email)
    }

    public struct Input {
        let idText: Driver<String>
        let passwordText: Driver<String>
        let passwordConfirmText: Driver<String>
        let emailText: Driver<String>
        let signupButtonDidTap: Signal<Void>
    }

    public struct Output {
        let isButtonEnabled: Driver<Bool>
        let idErrorDescription: PublishRelay<DescriptionType>
        let passwordErrorDescription: PublishRelay<DescriptionType>
        let passwordConfirmErrorDescription: PublishRelay<DescriptionType>
        let emailErrorDescription: PublishRelay<DescriptionType>
    }

    public func transform(input: Input) -> Output {
        let info = Driver.combineLatest(input.idText, input.passwordText, input.passwordConfirmText, input.emailText)
        let idErrorDescription = PublishRelay<DescriptionType>()
        let passwordErrorDescription = PublishRelay<DescriptionType>()
        let passwordConfirmErrorDescription = PublishRelay<DescriptionType>()
        let emailErrorDescription = PublishRelay<DescriptionType>()

        let isButtonEnabled = info
            .map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty && !$0.3.isEmpty }
            .distinctUntilChanged()

        input.signupButtonDidTap.asObservable()
            .withLatestFrom(info)
            .map { [weak self] idText, passwordText, passwordConfirmText, emailText -> Bool in
                guard let self = self else { return false }
                var isValid = true

                if idText.count < 5 || idText.count > 10 {
                    idErrorDescription.accept(.error(description: "5~10자여야 합니다."))
                    isValid = false
                } else {
                    idErrorDescription.accept(.clear)
                }

                if !self.isValidPassword(passwordText) {
                    passwordErrorDescription.accept(.error(description: "5자 이상 영어, 숫자, 특수문자가 포함되어야 합니다."))
                    isValid = false
                } else {
                    passwordErrorDescription.accept(.clear)
                }

                if passwordText != passwordConfirmText {
                    passwordConfirmErrorDescription.accept(.error(description: "입력하신 비밀번호와 일치하지 않습니다."))
                    isValid = false
                } else {
                    passwordConfirmErrorDescription.accept(.clear)
                }

                if !self.isValidEmail(emailText) {
                    emailErrorDescription.accept(.error(description: "올바른 이메일 형식이 아닙니다."))
                    isValid = false
                } else {
                    emailErrorDescription.accept(.clear)
                }

                return isValid
            }
            .filter { $0 }
            .map { _ in DailioStep.authPopIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            isButtonEnabled: isButtonEnabled,
            idErrorDescription: idErrorDescription,
            passwordErrorDescription: passwordErrorDescription,
            passwordConfirmErrorDescription: passwordConfirmErrorDescription,
            emailErrorDescription: emailErrorDescription
        )
    }

    public init() {}
}
