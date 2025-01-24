import UIKit
import Core

public struct TabItemInfo {
    let image: UIImage
    let tag: Int
}

public enum DailioTabBarType: Int {
    case schedule, chat, home, dashboard, setting

    func tabItemTuple() -> TabItemInfo {
        switch self {
        case .schedule:
            return .init(
                image: .filledCalender,
                tag: 0
            )
        case .chat:
            return .init(
                image: .comment,
                tag: 1
            )
        case .home:
            return .init(
                image: .filledHome,
                tag: 2
            )
        case .dashboard:
            return .init(
                image: .filledDashboard,
                tag: 3
            )
        case .setting:
            return .init(
                image: .setting,
                tag: 4
            )
        }
    }
}

public class DailioTabBarTypeItem: UITabBarItem {
    public init(_ type: DailioTabBarType) {
        super.init()
        let info = type.tabItemTuple()

        self.image = info.image
        self.tag = info.tag
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
