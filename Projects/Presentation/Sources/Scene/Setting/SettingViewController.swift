import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class SettingViewController: BaseViewController<SettingViewModel> {
    private let logoImageView = UIImageView(image: .logoHeader)
    private let navigateToProfile = UIImageView().then {
        $0.image = .person.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .gray300
        $0.backgroundColor = .gray200
        $0.layer.cornerRadius = 15
    }

    public override func configureNavigation() {
        self.navigationItem.leftBarButtonItem = .init(customView: logoImageView)
        self.navigationItem.rightBarButtonItem = .init(customView: navigateToProfile)
        navigateToProfile.snp.makeConstraints {
            $0.height.width.equalTo(30)
        }
    }
}
