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

    func commonInit() {
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
        self.captureImageView = UIImageView()

        self.addSubview(self.captureImageView)

        self.captureImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.left.equalToSuperview()
            make.bottom.equalTo(self.openLibraryButton.snp.top)

        }
    }

    func saveReceiptButtonTapped(){
        self.delegate.saveReceiptButtonTapped()
    }

    func openLibraryButtonTapped(){
        self.delegate.openLibraryButtonTapped()
    }

    func handleCameraImage(){
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.sourceType = .camera
            picker.present(picker, animated: true, completion: nil)
        } else {
            print("No camera")
        }

        picker.allowsEditing = true
    }

    func handleLibraryImage(){
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.sourceType = .photoLibrary
            picker.present(picker, animated: true, completion: nil)
            //present(picker, animated: true, completion: nil)

        } else {
            print("No photo library")
        }

        picker.allowsEditing = true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerEditedImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }




    

    



}
