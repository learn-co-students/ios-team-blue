import UIKit
import SnapKit

class ScanReceiptView: UIView {

    var saveReceiptButton: UIButton!
    var rescanReceiptButton: UIButton!
    var imageView: UIImageView!
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
        self.createSaveReceiptButton()
        self.createRescanReceiptButton()
        self.createBackground()
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
            make.height.equalTo(100)
        }

        self.saveReceiptButton.addTarget(self, action: #selector(saveReceiptButtonTapped), for: .touchUpInside)

    }

    func createRescanReceiptButton() {
        self.rescanReceiptButton = {
            let rr = UIButton()
            rr.backgroundColor = Style.flatironBlue
            rr.titleLabel?.textColor = UIColor.white
            rr.titleLabel?.font = UIFont(name: Style.bold, size: 18)
            rr.layer.borderWidth = 1
            rr.layer.cornerRadius = 5
            rr.setTitle("Rescan Receipt", for: .normal)
            return rr
        }()

        self.addSubview(self.rescanReceiptButton)

        self.rescanReceiptButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview()
            make.height.equalTo(100)
        }

        self.rescanReceiptButton.addTarget(self, action: #selector(rescanReceiptButtonTapped), for: .touchUpInside)

    }

    func createImageView(){
        self.imageView = {
            let iv = UIImageView()
            return iv
        }()

        self.addSubview(self.imageView)

        self.imageView.snp.makeConstraints { (make) in
            make.top.width.left.equalToSuperview()
            make.bottom.equalTo(self.rescanReceiptButton.snp.top)

        }
    }

    func saveReceiptButtonTapped(){
        self.delegate.saveReceiptButtonTapped()
    }

    func rescanReceiptButtonTapped(){
        self.delegate.rescanReceiptButtonTapped()
    }

}
