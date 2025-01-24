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

        container.register(ScheduleViewController.self) { resolver in
            ScheduleViewController(viewModel: resolver.resolve(ScheduleViewModel.self)!)
        }
        container.register(ScheduleViewModel.self) { _ in
            return ScheduleViewModel()
        }
        container.register(ChatViewController.self) { resolver in
            ChatViewController(viewModel: resolver.resolve(ChatViewModel.self)!)
        }
        container.register(ChatViewModel.self) { _ in
            return ChatViewModel()
        }
        container.register(HomeViewController.self) { resolver in
            HomeViewController(viewModel: resolver.resolve(HomeViewModel.self)!)
        }
        container.register(HomeViewModel.self) { _ in
            return HomeViewModel()
        }
        container.register(DashboardViewController.self) { resolver in
            DashboardViewController(viewModel: resolver.resolve(DashboardViewModel.self)!)
        }
        container.register(DashboardViewModel.self) { _ in
            return DashboardViewModel()
        }
        container.register(SettingViewController.self) { resolver in
            SettingViewController(viewModel: resolver.resolve(SettingViewModel.self)!)
        }
        container.register(SettingViewModel.self) { _ in
            return SettingViewModel()
        }
    }
}
