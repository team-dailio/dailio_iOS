import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain
import DesignSystem

public class SettingViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()
    public init() {}
    public struct Input {
        let deleteAccountButtonDidTab: Observable<Void>
    }
    public struct Output {
        let deleteAccountButtonTapped: Observable<Void>
    }
    public func transform(input: Input) -> Output {
        let deleteAccountButtonTapped = input.deleteAccountButtonDidTab
        return Output(
            deleteAccountButtonTapped: deleteAccountButtonTapped
        )
    }
}
