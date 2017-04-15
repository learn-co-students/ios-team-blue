import UIKit
import SnapKit

class ManualEntryView: UIView {

    var foodEntryTextField: UITextField!
    var saveFoodButton: UIButton!
    weak var delegate: ManualEntryViewDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    func commonInit() {
        self.createFoodEntryTextField()
        self.createSaveFoodButton()
        self.createBackground()
    }

    func createBackground() {
        self.backgroundColor = UIColor.white
    }

    func createFoodEntryTextField() {
        self.foodEntryTextField = UITextField()
        self.foodEntryTextField.keyboardType = .default
        self.foodEntryTextField.layer.cornerRadius = 10
        self.foodEntryTextField.textColor = Style.flatironBlue
        self.foodEntryTextField.borderStyle = .roundedRect
        self.foodEntryTextField.layer.borderWidth = 2
        self.foodEntryTextField.layer.borderColor = Style.flatironBlue.cgColor

        self.addSubview(self.foodEntryTextField)

        self.foodEntryTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(270)
            make.left.equalToSuperview()
            make.width.equalToSuperview().offset(0.8)
        }
    }

    func createSaveFoodButton() {

        self.saveFoodButton = {
            let sf = UIButton()
            sf.backgroundColor = Style.flatironBlue
            sf.titleLabel?.textColor = UIColor.white
            sf.titleLabel?.font = UIFont(name: Style.bold, size: 18)
            sf.layer.cornerRadius = 10
            sf.layer.borderWidth = 1
            sf.layer.borderColor = Style.flatironBlue.cgColor
            sf.setTitle("Save Ingredient", for: .normal)
            return sf
        }()

        self.addSubview(self.saveFoodButton)

        self.saveFoodButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.foodEntryTextField.snp.bottom).offset(2)
            make.left.equalToSuperview
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.05)

        }

        self.saveFoodButton.addTarget(self, action: #selector(saveFoodButtonTapped), for: .touchUpInside)
    }

    func saveFoodButtonTapped() {
        self.delegate.saveFoodButtonTapped()
    }
    
    
}
