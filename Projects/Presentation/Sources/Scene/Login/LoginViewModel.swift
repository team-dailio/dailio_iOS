import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class LoginViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()

    public struct Input {
        let idText: Observable<String>
        let passwordText: Observable<String>
    }
    public struct Output {
        let isButtonEnabled: Observable<Bool>
    }

    public func transform(input: Input) -> Output {
        let isButtonEnabled = Observable
            .combineLatest(input.idText, input.passwordText)
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .distinctUntilChanged()

        return Output(isButtonEnabled: isButtonEnabled)
    }

    public init() {}
}
