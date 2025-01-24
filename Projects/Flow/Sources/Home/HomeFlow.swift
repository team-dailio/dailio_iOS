import UIKit
import RxFlow
import Swinject
import Core
import Presentation

public class HomeFlow: Flow {
    public let container: Container
    private var rootViewController = BaseNavigationController()
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    public func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? DailioStep else { return .none }

        switch step {
        case .homeIsRequired:
            return navigateToHome()
        default:
            return .none
        }
    }

    private func navigateToHome() -> FlowContributors {
        let homeVC = container.resolve(HomeViewController.self)!

        self.rootViewController.pushViewController(homeVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: homeVC,
            withNextStepper: homeVC.viewModel
        ))
    }

}
