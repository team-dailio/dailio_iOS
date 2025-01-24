import UIKit
import RxFlow
import Swinject
import Core
import Presentation

public class DashboardFlow: Flow {
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
        case .dashboardIsRequired:
            return navigateToDashboard()
        default:
            return .none
        }
    }

    private func navigateToDashboard() -> FlowContributors {
        let dashboardVC = container.resolve(DashboardViewController.self)!

        self.rootViewController.pushViewController(dashboardVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: dashboardVC,
            withNextStepper: dashboardVC.viewModel
        ))
    }

}
