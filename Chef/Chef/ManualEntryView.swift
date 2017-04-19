import UIKit
import SnapKit

class ManualEntryView: UIView {

    var foodEntryTextField: UITextField!
    var saveFoodButton: UIButton!
    weak var delegate: ManualEntryViewDelegate!
    var tableView: UITableView!
    var autoCompleteTableView: UITableView!

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
        self.createAutoCpmpleteTable()
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
            make.top.equalToSuperview().offset(150)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.left.equalToSuperview().offset(20)
        }
    }
    //TODO: - Add cancel button to return to previous view without making any changes.
    func createSaveFoodButton() {

        self.saveFoodButton = {
            let sf = UIButton()
            sf.backgroundColor = Style.flatironBlue
            sf.titleLabel?.textColor = UIColor.white
            sf.titleLabel?.font = UIFont(name: Style.bold, size: 18)
            sf.layer.cornerRadius = 10
            sf.layer.borderWidth = 1
            sf.layer.borderColor = Style.flatironBlue.cgColor
            sf.setTitle("Save", for: .normal)
            return sf
        }()

        self.addSubview(self.saveFoodButton)

        self.saveFoodButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.foodEntryTextField.snp.top)
            make.left.equalTo(foodEntryTextField.snp.right).offset(3)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(foodEntryTextField.snp.height)
        }
        self.saveFoodButton.addTarget(self, action: #selector(saveFoodButtonTapped), for: .touchUpInside)
    }

    func createAutoCpmpleteTable() {
        autoCompleteTableView = UITableView()
        autoCompleteTableView.isHidden = true
        self.addSubview(autoCompleteTableView)
        autoCompleteTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        autoCompleteTableView.snp.makeConstraints { (make) in
            make.top.equalTo(foodEntryTextField.snp.bottom).offset(3)
            make.width.height.equalToSuperview().multipliedBy(0.5)
            make.left.equalTo(foodEntryTextField.snp.left)
        }
    }

    func saveFoodButtonTapped() {
        self.delegate.saveFoodButtonTapped()
    }
    
}
