import UIKit
import SnapKit

class ManualEntryView: UIView {

    weak var delegate: ManualEntryViewDelegate!
    var tableView: UITableView!
    var foodEntryTextField: FoodEntryTextField!
    var saveFoodButton: UIButton!
    var cancelButton: UIButton!
    var autoCompleteTableView: UITableView!


    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.backgroundColor = Colors.veryLightGray
        self.createUI()
        self.constrainUI()
    }


    // MARK: - Actions

    func saveFoodButtonTapped() {
        self.delegate.saveFoodButtonTapped()
    }

    func cancelButtonTapped() {
        print("Cancel button tapped")
        self.delegate.cancelButtonTapped()
    }


    // MARK: - UI Setup

    private func createUI() {
        self.foodEntryTextField = FoodEntryTextField()
        self.addSubview(self.foodEntryTextField)

        self.saveFoodButton = {
            let sf = UIButton()
            sf.backgroundColor = Colors.flatironBlue
            sf.titleLabel?.textColor = UIColor.white
            sf.titleLabel?.font = Fonts.heavy18
            sf.layer.cornerRadius = 1
            sf.setTitle("Save", for: .normal)
            sf.addTarget(self, action: #selector(saveFoodButtonTapped), for: .touchUpInside)
            return sf
        }()
        self.addSubview(self.saveFoodButton)

        self.cancelButton = {
            let cancel = UIButton()
            cancel.backgroundColor = Colors.flatironBlue
            cancel.titleLabel?.textColor = UIColor.white
            cancel.titleLabel?.font = Fonts.heavy18
            cancel.layer.cornerRadius = 1
            cancel.setTitle("Cancel", for: .normal)
            cancel.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
            return cancel
        }()
        self.addSubview(self.cancelButton)

        self.autoCompleteTableView = {
            let actv = UITableView()
            actv.isHidden = true
            actv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            return actv
        }()
        self.addSubview(self.autoCompleteTableView)
    }

    private func constrainUI() {
        self.foodEntryTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalTo(self.saveFoodButton.snp.right).offset(-62)
            make.top.equalToSuperview().offset(30)
        }

        self.saveFoodButton.snp.makeConstraints { make in
            make.right.equalTo(self.cancelButton.snp.left).offset(-4)
            make.top.equalTo(self.foodEntryTextField.snp.top)
            make.width.equalTo(self.cancelButton.snp.width)
            make.height.equalTo(self.foodEntryTextField.snp.height)
        }

        self.cancelButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8)
            make.left.equalTo(self.saveFoodButton.snp.right).offset(-4)
            make.top.equalTo(self.foodEntryTextField.snp.top)
            make.height.equalTo(self.foodEntryTextField.snp.height)
        }

        self.autoCompleteTableView.snp.makeConstraints { make in
            make.top.equalTo(foodEntryTextField.snp.bottom).offset(3)
            make.width.height.equalTo(foodEntryTextField.snp.width)
            make.left.equalTo(foodEntryTextField.snp.left)
        }
    }

}
