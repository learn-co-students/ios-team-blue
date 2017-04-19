import UIKit
import SnapKit

class ManualEntryView: UIView {

    var foodEntryTextField: UITextField!
    var saveFoodButton: UIButton!
    var cancelButton: UIButton!
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
        self.createCancelButon()
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
        self.foodEntryTextField.textColor = Colors.flatironBlue
        self.foodEntryTextField.borderStyle = .roundedRect
        self.foodEntryTextField.layer.borderWidth = 2
        self.foodEntryTextField.layer.borderColor = Colors.flatironBlue.cgColor

        self.addSubview(self.foodEntryTextField)

        self.foodEntryTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(150)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.left.equalToSuperview().offset(20)
        }
    }
    //TODO: - Add cancel button to return to previous view without making any changes.
    func createSaveFoodButton() {

        self.saveFoodButton = {
            let sf = UIButton()
            sf.backgroundColor = Colors.flatironBlue
            sf.titleLabel?.textColor = UIColor.white
            sf.titleLabel?.font = Fonts.heavy18
            sf.layer.cornerRadius = 10
            sf.layer.borderWidth = 1
            sf.layer.borderColor = Colors.flatironBlue.cgColor
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

    func createCancelButon() {
        self.cancelButton = {
            let cancel = UIButton()
            cancel.backgroundColor = Colors.flatironBlue
            cancel.titleLabel?.textColor = UIColor.white
            cancel.titleLabel?.font = Fonts.heavy18
            cancel.layer.cornerRadius = 10
            cancel.layer.borderWidth = 1
            cancel.layer.borderColor = Colors.flatironBlue.cgColor
            cancel.setTitle("Cancel", for: .normal)
            return cancel
        }()

        self.addSubview(self.cancelButton)

        self.cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.foodEntryTextField.snp.top)
            make.left.equalTo(saveFoodButton.snp.right).offset(3)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(foodEntryTextField.snp.height)
        }
        self.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }

    func createAutoCpmpleteTable() {
        autoCompleteTableView = UITableView()
        autoCompleteTableView.isHidden = true
        self.addSubview(autoCompleteTableView)
        autoCompleteTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        autoCompleteTableView.snp.makeConstraints { (make) in
            make.top.equalTo(foodEntryTextField.snp.bottom).offset(3)
            make.width.height.equalTo(foodEntryTextField.snp.width)
            make.left.equalTo(foodEntryTextField.snp.left)
        }
    }

    func saveFoodButtonTapped() {
        self.delegate.saveFoodButtonTapped()
    }
    func cancelButtonTapped() {
        print("Cancel button tapped")
        self.delegate.cancelButtonTapped()
    }
    
}
