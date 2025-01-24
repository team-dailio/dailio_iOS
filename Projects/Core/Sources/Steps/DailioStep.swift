import Foundation

import RxFlow

public enum DailioStep: Step {
    case loginIsRequired
    case signupIsRequired
    case authPopIsRequired

    case tabIsRequired
    case appIsRequired
    case popIsRequired

    case scheduleIsRequired
    case chatIsRequired
    case homeIsRequired
    case dashboardIsRequired
    case settingIsRequired
}
