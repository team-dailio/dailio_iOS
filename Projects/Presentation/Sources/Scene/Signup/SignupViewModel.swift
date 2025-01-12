import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class SignupViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()

    public struct Input {
        let idText: Observable<String>
        let passwordText: Observable<String>
        let passwordConfirmText: Observable<String>
        let emailText: Observable<String>
        let signupButtonDidTap: Observable<Void>
    }
    public struct Output {
        let isButtonEnabled: Observable<Bool>
    }

    public func transform(input: Input) -> Output {
        let isButtonEnabled = Observable
            .combineLatest(input.idText, input.passwordText, input.passwordConfirmText, input.emailText)
            .map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty && !$0.3.isEmpty }
            .distinctUntilChanged()
        input.signupButtonDidTap
            .map { DailioStep.authPopIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(isButtonEnabled: isButtonEnabled)
    }

    public init() {}
}
