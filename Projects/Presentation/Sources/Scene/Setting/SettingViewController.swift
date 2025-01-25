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
        $0.image = .profile
        $0.layer.cornerRadius = 15
    }
    private let profileImageView = UIImageView().then {
        $0.image = .profile
        $0.layer.cornerRadius = 80
    }
    private let editButton = UIButton().then {
        $0.backgroundColor = .primary500
        $0.layer.cornerRadius = 28
        $0.setImage(.edit.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .white100
        $0.imageEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    private let idLabel = UILabel().then {
        $0.setDailioText("circle08", font: .body1, color: .black100)
    }
    private let emailLabel = UILabel().then {
        $0.setDailioText("hawon9781@dsm.hs.kr", font: .body3, color: .gray400)
    }

    public override func addView() {
        [
            profileImageView,
            editButton,
            idLabel,
            emailLabel
        ].forEach { view.addSubview($0) }
    }
    public override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(160)
        }
        editButton.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView.snp.bottom).inset(-14)
            $0.trailing.equalTo(profileImageView.snp.trailing).inset(-14)
          $0.height.width.equalTo(56)
        }
        idLabel.snp.makeConstraints {
            $0.top.equalTo(editButton.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
    public override func configureNavigation() {
        self.navigationItem.leftBarButtonItem = .init(customView: logoImageView)
        self.navigationItem.rightBarButtonItem = .init(customView: navigateToProfile)
        navigateToProfile.snp.makeConstraints {
            $0.height.width.equalTo(30)
        }
    }
}
extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
