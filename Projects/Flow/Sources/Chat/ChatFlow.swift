import UIKit
import RxFlow
import Swinject
import Core
import Presentation

public class ChatFlow: Flow {
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
        case .chatIsRequired:
            return navigateToChat()
        default:
            return .none
        }
    }

    private func navigateToChat() -> FlowContributors {
        let chatVC = container.resolve(ChatViewController.self)!

        self.rootViewController.pushViewController(chatVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: chatVC,
            withNextStepper: chatVC.viewModel
        ))
    }

}
