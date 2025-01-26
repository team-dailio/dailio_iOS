import UIKit

import SnapKit
import Then

import RxSwift
import RxCocoa

import Core

public class DailioAlert: UIViewController {
    private let disposeBag = DisposeBag()

    private let backgroundView = UIView().then {
        $0.backgroundColor = .white100
        $0.layer.cornerRadius = 16
    }
    private let titleLabel = UILabel().then {
        $0.setDailioText("", font: .heading6, color: .black100)
    }
    private let explainLabel = UILabel().then {
        $0.setDailioText("", font: .body3, color: .gray400)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    private let confirmButton = DailioAuthButton("확인").then {
        $0.backgroundColor = .primary500
        $0.setTitleColor(.primary100, for: .normal)
        $0.alpha = 1
        $0.isEnabled = true
    }
    private let cancelButton = UIButton().then {
        $0.setImage(.cancel, for: .normal)
    }

    public init(titleText: String, explainText: String) {
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text = titleText
        self.explainLabel.text = explainText
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black100.withAlphaComponent(0.6)
        bindActions()
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        addView()
        setLayout()
    }

    private func bindActions() {
        cancelButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true)
            }.disposed(by: disposeBag)
    }
    private func addView() {
        view.addSubview(backgroundView)
        [
            titleLabel,
            explainLabel,
            confirmButton,
            cancelButton
        ].forEach { backgroundView.addSubview($0) }
    }
    private func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(39)
            $0.height.equalTo(188)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.centerX.equalToSuperview()
        }
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        confirmButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        cancelButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
