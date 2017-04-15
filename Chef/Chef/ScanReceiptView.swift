import UIKit
import SnapKit

class ScanReceiptView: UIView {

    var saveReceiptButton: UIButton!
    var rescanReceiptButton: UIButton!
    weak var delegate: ScanReceiptViewDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    func commonInit() {

    }

    func createBackground() {
        self.backgroundColor = UIColor.white
    }

    func createSaveReceiptButton() {
        self.saveReceiptButton = {
            let sr = UIButton()
            sr.backgroundColor = Style.flatironBlue
            sr.titleLabel?.textColor = UIColor.white
            sr.titleLabel?.font = UIFont(name: Style.bold, size: 18)
            sr.layer.borderWidth = 1
            sr.layer.cornerRadius = 5
            sr.setTitle("Save Receipt", for: .normal)
            return sr
        }()

        self.addSubview(self.saveReceiptButton)

        self.saveReceiptButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview()
        }

        self.saveReceiptButton.addTarget(self, action: #selector(saveReceiptButtonTapped), for: .touchUpInside)

    }

    func createRescanReceiptButton() {
        self.rescanReceiptButton = {
            let sr = UIButton()
            sr.backgroundColor = Style.flatironBlue
            sr.titleLabel?.textColor = UIColor.white
            sr.titleLabel?.font = UIFont(name: Style.bold, size: 18)
            sr.layer.borderWidth = 1
            sr.layer.cornerRadius = 5
            sr.setTitle("Rescan Receipt", for: .normal)
            return sr
        }()

        self.addSubview(self.rescanReceiptButton)

        self.rescanReceiptButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview()
        }

        self.rescanReceiptButton.addTarget(self, action: #selector(saveReceiptButtonTapped), for: .touchUpInside)

    }

    func saveReceiptButtonTapped(){
        self.delegate.saveReceiptButtonTapped()
    }

    func rescanReceiptButtonTapped(){
        self.delegate.rescanReceiptButtonTapped()
    }

}
