import UIKit
import SnapKit
import Photos
import MobileCoreServices


class ScanReceiptView: UIView {

    var saveReceiptButton: UIButton!
    var openLibraryButton: UIButton!
    var captureImageView: UIImageView!
    weak var delegate: ScanReceiptViewDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.createSaveReceiptButton()
        self.createOpenLibraryButton()
        self.createBackground()
        self.createImageView()
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

    func createOpenLibraryButton() {
        self.openLibraryButton = {
            let ol = UIButton()
            ol.backgroundColor = Style.flatironBlue
            ol.titleLabel?.textColor = UIColor.white
            ol.titleLabel?.font = UIFont(name: Style.bold, size: 18)
            ol.layer.borderWidth = 1
            ol.layer.cornerRadius = 5
            ol.setTitle("Open Library", for: .normal)
            return ol
        }()

        self.addSubview(self.openLibraryButton)

        self.openLibraryButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview()
            make.height.equalTo(100)
        }

        self.openLibraryButton.addTarget(self, action: #selector(openLibraryButtonTapped), for: .touchUpInside)
    }

    func createImageView(){
        self.captureImageView = {
            let ci = UIImageView()
            ci.layer.borderColor =  Style.flatironBlue.cgColor
            return ci
        }()

        self.addSubview(self.captureImageView)

        self.captureImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.left.equalToSuperview()
            make.bottom.equalTo(self.openLibraryButton.snp.top)
        }
    }

    // MARK: - Delegate


    func saveReceiptButtonTapped(){
        self.delegate.saveReceiptButtonTapped()
    }

    func openLibraryButtonTapped(){
        self.delegate.openLibraryButtonTapped()
    }




    

    



}
