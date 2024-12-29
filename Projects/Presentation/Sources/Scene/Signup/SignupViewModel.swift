import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class SignupViewModel: BaseViewModel {
    public struct Input {}

    public struct Output {}

    public func transform(input: Input) -> Output {
        return Output()
    }

    public init() {}
}
