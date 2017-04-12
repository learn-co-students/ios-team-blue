import UIKit
import SnapKit

extension UIView {

    func snapToSuperview() {
        guard let _ = self.superview else {
            print("error -- no superview")
            return
        }

        self.snp.makeConstraints { (make) in
            make.top.left.width.height.equalToSuperview()
        }
    }
    
}
