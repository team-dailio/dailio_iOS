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
    }

    public func transform(input: Input) -> Output {
        let info = Driver.combineLatest(input.idText, input.passwordText, input.passwordConfirmText, input.emailText)
        let idErrorDescription = PublishRelay<DescriptionType>()
        let passwordErrorDescription = PublishRelay<DescriptionType>()
        let passwordConfirmErrorDescription = PublishRelay<DescriptionType>()

        let isButtonEnabled = info
            .map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty && !$0.3.isEmpty }
            .distinctUntilChanged()

        input.signupButtonDidTap.asObservable()
            .withLatestFrom(info)
            .filter { idText, passwordText, passwordConfirmText, emailText in
                let passwordExpression =
                "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*(),.?\":{}|<>])[A-Za-z\\d!@#$%^&*(),.?\":{}|<>]{5,}$"
                if idText.count < 5 || idText.count > 10 {
                    idErrorDescription.accept(.error(description: "5~10자여야 합니다."))
                    return false
                } else if !(passwordText ~= passwordExpression) {
                    passwordErrorDescription.accept(.error(description: "5자 이상 영어, 숫자, 특수문자가 포함되어야 합니다."))
                    return false
                } else if passwordText != passwordConfirmText {
                    passwordConfirmErrorDescription.accept(.error(description: "입력하신 비밀번호와 일치하지 않습니다."))
                    return false
                }
                return true
            }
            .map { _ in DailioStep.authPopIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            isButtonEnabled: isButtonEnabled,
            idErrorDescription: idErrorDescription,
            passwordErrorDescription: passwordErrorDescription,
            passwordConfirmErrorDescription: passwordConfirmErrorDescription
        )
    }

    public init() {}
}
