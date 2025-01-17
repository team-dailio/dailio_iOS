import UIKit
import UserNotifications

import Swinject

import Firebase

import Core
import Data
import Presentation

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    static var container = Container()
    var assembler: Assembler!

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        assembler = Assembler([
            PresentationAssembly()
         ], container: AppDelegate.container)

        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {}

}
