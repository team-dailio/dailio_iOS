import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class SettingViewController: BaseViewController<SettingViewModel> {
    private let logoImageView = UIImageView(image: .logoHeader)

    public override func configureNavigation() {
        self.navigationItem.leftBarButtonItem = .init(customView: logoImageView)
    }
}
