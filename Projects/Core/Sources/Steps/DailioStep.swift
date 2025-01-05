import Foundation

import RxFlow

public enum DailioStep: Step {
    case loginIsRequired
    case signupIsRequired
}
