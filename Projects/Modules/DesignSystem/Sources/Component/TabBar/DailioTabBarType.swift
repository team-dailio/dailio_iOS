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

        self.imageInsets = UIEdgeInsets(top: 16, left: 0, bottom: -16, right: 0)
        let resizedImage = info.image.resized(to: CGSize(width: 32, height: 32))

        self.image = resizedImage
        self.tag = info.tag
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }
}
