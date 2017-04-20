import UIKit
import SnapKit

class ReceiptDataCell: UITableViewCell {

    var ingredientTextField: UITextField!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

        self.ingredientTextField.layer.borderWidth = 2
        self.ingredientTextField.layer.borderColor = Colors.flatironBlue.cgColor

        self.ingredientTextField.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(1)
            make.width.equalToSuperview().multipliedBy(0.90)
            make.height.equalToSuperview().multipliedBy(0.95)
        }
    }
    
}
