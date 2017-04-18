import UIKit
import SnapKit

class ReceiptDataCell: UITableViewCell {

    var ingredientTextField: UITextField!

    init(frame: CGRect) {
        //      init(frame: frame)
        super.init(style: .default, reuseIdentifier: "ReceiptDataCell")
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.backgroundColor = .white

        self.ingredientTextField = UITextField()
        self.addSubview(ingredientTextField)
        self.ingredientTextField.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(2)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        
        
    }
    
}
