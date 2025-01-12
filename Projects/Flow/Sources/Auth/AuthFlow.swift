import UIKit

import RxFlow
import Swinject

import Core
import Presentation

public class AuthFlow: Flow {
    public let container: Container
    private var rootViewController = UINavigationController()
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    public func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? DailioStep else { return .none }

        switch step {
        case .signupIsRequired:
            return navigateToSignup()
        case .loginIsRequired:
            return navigateToLogin()
        case .authPopIsRequired:
            return signupPop()
        default:
            return .none
        }
    }

    private func navigateToSignup() -> FlowContributors {
        let signupVC = container.resolve(SignupViewController.self)!
        self.rootViewController.pushViewController(signupVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: signupVC,
            withNextStepper: signupVC.viewModel
        ))
    }
    private func navigateToLogin() -> FlowContributors {
        let loginVC = container.resolve(LoginViewController.self)!
        self.rootViewController.pushViewController(loginVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: loginVC,
            withNextStepper: loginVC.viewModel
        ))
    }
    private func signupPop() -> FlowContributors {
        self.rootViewController.popViewController(animated: true)
        return .none
    }
}
