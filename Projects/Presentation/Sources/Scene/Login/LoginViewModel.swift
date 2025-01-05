import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class LoginViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()

    public struct Input {
        let idText: Observable<String>
        let passwordText: Observable<String>
        let signupButtonDidTap: Observable<Void>
    }
    public struct Output {
        let isButtonEnabled: Observable<Bool>
    }

    public func transform(input: Input) -> Output {
        let isButtonEnabled = Observable
            .combineLatest(input.idText, input.passwordText)
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .distinctUntilChanged()

        input.signupButtonDidTap
            .bind { [weak self] in
                print("회원가입 버튼 눌림")
                self?.steps.accept(DailioStep.signupRequired)
            }
            .disposed(by: disposeBag)

        return Output(isButtonEnabled: isButtonEnabled)
    }

    public init() {}
}
