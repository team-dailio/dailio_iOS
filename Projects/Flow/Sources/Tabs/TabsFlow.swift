import UIKit
import RxFlow
import RxCocoa
import RxSwift
import Swinject
import Core
import DesignSystem
import Presentation

public class TabsFlow: Flow {
    public let container: Container
    private let rootViewController =  BaseTabBarController()
    public var root: Presentable {
        return self.rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    private lazy var scheduleFlow = ScheduleFlow(container: container)
    private lazy var chatFlow = ChatFlow(container: container)
    private lazy var homeFlow = HomeFlow(container: container)
    private lazy var dashboardFlow = DashboardFlow(container: container)
    private lazy var settingFlow = SettingFlow(container: container)

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DailioStep else { return .none }

        switch step {
        case .tabIsRequired:
            return setupTabBar()
        case .appIsRequired:
            return dismissToLogin()
        case .popIsRequired:
            return .end(forwardToParentFlowWithStep: DailioStep.tabIsRequired)
        default:
            return .none
        }
    }

    private func setupTabBar() -> FlowContributors {
        Flows.use(
            scheduleFlow,
            chatFlow,
            homeFlow,
            dashboardFlow,
            settingFlow,
            when: .created
        ) { schedule, chat, home, dashboard, setting in
            schedule.tabBarItem = DailioTabBarTypeItem(.schedule)
            chat.tabBarItem = DailioTabBarTypeItem(.chat)
            home.tabBarItem = DailioTabBarTypeItem(.home)
            dashboard.tabBarItem = DailioTabBarTypeItem(.dashboard)
            setting.tabBarItem = DailioTabBarTypeItem(.setting)

            self.rootViewController.setViewControllers([
                schedule,
                chat,
                home,
                dashboard,
                setting
            ], animated: false)
        }
        return .multiple(flowContributors: [
            .contribute(
                withNextPresentable: scheduleFlow,
                withNextStepper: OneStepper(withSingleStep: DailioStep.scheduleIsRequired)
            ),
            .contribute(
                withNextPresentable: chatFlow,
                withNextStepper: OneStepper(withSingleStep: DailioStep.chatIsRequired)
            ),
            .contribute(
                withNextPresentable: homeFlow,
                withNextStepper: OneStepper(withSingleStep: DailioStep.homeIsRequired)
            ),
            .contribute(
                withNextPresentable: dashboardFlow,
                withNextStepper: OneStepper(withSingleStep: DailioStep.dashboardIsRequired)
            ),
            .contribute(
                withNextPresentable: settingFlow,
                withNextStepper: OneStepper(withSingleStep: DailioStep.settingIsRequired)
            )
        ])
    }

    private func dismissToLogin() -> FlowContributors {
        UIView.transition(
            with: self.rootViewController.view.window!,
            duration: 0.5,
            options: .transitionCrossDissolve) {
                self.rootViewController.dismiss(animated: false)
            }

        return .end(forwardToParentFlowWithStep: DailioStep.loginIsRequired)
    }

}
