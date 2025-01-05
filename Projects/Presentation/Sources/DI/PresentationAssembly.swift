import Foundation

import Swinject

import Core
import Domain

public final class PresentationAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(SignupViewController.self) { resolver in
            SignupViewController(viewModel: resolver.resolve(SignupViewModel.self)!)
        }
        container.register(SignupViewModel.self) { _ in
            return SignupViewModel()
        }
        container.register(LoginViewController.self) { resolver in
            LoginViewController(viewModel: resolver.resolve(LoginViewModel.self)!)
        }
        container.register(LoginViewModel.self) { _ in
            return LoginViewModel()
        }
    }
}
