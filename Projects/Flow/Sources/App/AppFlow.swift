import UIKit

import RxFlow
import Swinject

import Core

public class AppFlow: Flow {
    private var window: UIWindow
    private let container: Container
    public var root: RxFlow.Presentable {
        return window
    }

    public init(window: UIWindow, container: Container) {
        self.window = window
        self.container = container
    }

    public func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? DailioStep else {
            return .none
        }

        switch step {
        case .loginIsRequired:
            return navigationToLogin()
        case .tabIsRequired:
            return presentTabView()
        default:
            return .none
        }
    }

    private func navigationToLogin() -> FlowContributors {
        let loginFlow = AuthFlow(container: self.container)

        Flows.use(loginFlow, when: .created) { [weak self] root in
            self?.window.rootViewController = root
        }

        return .one(
            flowContributor: .contribute(
                withNextPresentable: loginFlow,
                withNextStepper: OneStepper(
                    withSingleStep: DailioStep.loginIsRequired
                )
            )
        )
    }
    private func presentTabView() -> FlowContributors {
        let tabsFlow = TabsFlow(container: self.container)

        Flows.use(tabsFlow, when: .created) { [weak self] root in
            UIView.transition(
                with: self!.window,
                duration: 0.5,
                options: .transitionCrossDissolve
            ) {
                self?.window.rootViewController = root
            }
        }

        return .one(
            flowContributor: .contribute(
                withNextPresentable: tabsFlow,
                withNextStepper: OneStepper(
                    withSingleStep: DailioStep.tabIsRequired
                )
            )
        )
    }
}
