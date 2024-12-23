import UIKit

import RxSwift
import RxCocoa

import Core

public class BaseViewController<ViewModel: BaseViewModel>: UIViewController {
    public let disposeBag = DisposeBag()
    public var viewModel: ViewModel

    public var viewWillAppearRelay = PublishRelay<Void>()

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        bind()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearRelay.accept(())
        bindAction()
    }
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addView()
        setLayout()
    }

    public func attribute() {
        self.view.backgroundColor = .white
    }
    public func addView() {}
    public func setLayout() {}
    public func bind() {}
    public func bindAction() {}
}
