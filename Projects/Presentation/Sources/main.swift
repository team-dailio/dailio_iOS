import Foundation
import UIKit
import SnapKit
import Then

public class TestViewController: UIViewController {
    let label = UILabel().then {
        $0.text = "짜쟌"
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
}
