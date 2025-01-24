import UIKit
import RxFlow
import Swinject
import Core
import Presentation

public class SettingFlow: Flow {
    public let container: Container
    private var rootViewController = UINavigationController()
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    public func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? DailioStep else { return .none }

        switch step {
        case .settingIsRequired:
            return navigateToSetting()
        default:
            return .none
        }
    }

    private func navigateToSetting() -> FlowContributors {
        let vc = container.resolve(SettingViewController.self)!

        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: vc,
            withNextStepper: vc.viewModel
        ))
    }

}

