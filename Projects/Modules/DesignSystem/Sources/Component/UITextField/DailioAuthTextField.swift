import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

public final class DailioAuthTextField: UIView {
    public let authTextField = UITextField().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 12
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.leftViewMode = .always
    }
    private let authLabelView = UIView().then {
        $0.backgroundColor = UIColor.white
    }
    private let authLabel = UILabel().then {
        $0.setDailioText("", font: .caption4, color: .black)
    }
    private let errorLabel = UILabel().then {
        $0.setDailioText("", font: .caption1, color: .error)
        $0.isHidden = true
    }

    public init(_ text: String, placeholder: String) {
        super.init(frame: .zero)
        self.authLabel.text = text
        self.authTextField.placeholder = placeholder

        addView()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setDescription(_ descriptionType: DescriptionType) {
        switch descriptionType {
        case .error(let description):
            errorLabel.text = description
            errorLabel.isHidden = false
        default:
            errorLabel.text = nil
            errorLabel.isHidden = true
        }
    }

    private func addView() {
        [
            authTextField,
            authLabelView,
            errorLabel
        ].forEach { self.addSubview($0) }
        self.authLabelView.addSubview(authLabel)
    }
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(70)
        }
        authTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
        authLabelView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(authTextField.snp.leading).inset(12)
            $0.height.equalTo(16)
        }
        authLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        errorLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(authTextField.snp.leading)
        }
    }
}
