import UIKit

import RxFlow
import Swinject

import Core
import Presentation

public class LoginFlow: Flow {
    public let container: Container
    private let rootViewController: LoginViewController
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
        self.rootViewController = LoginViewController(viewModel: container.resolve(LoginViewModel.self)!)
    }

    public func navigate(to step: any RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? DailioStep else { return .none }

        switch step {
        case .signupRequired:
            return navigateToSignup()
        }
    }

    private func navigateToSignup() -> FlowContributors {
        let vc = SignupViewController(viewModel: container.resolve(SignupViewModel.self)!)
        self.rootViewController.navigationController?.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: vc,
            withNextStepper: vc.viewModel
        ))
    }
}
