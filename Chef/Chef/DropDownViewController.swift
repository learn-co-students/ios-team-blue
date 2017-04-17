import UIKit
import MobileCoreServices
import Photos

class DropDownViewController: UIViewController, DropDrownViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    var dropDownView: DropDownView!

    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()

        self.dropDownView = DropDownView()
        self.dropDownView.delegate = self

        self.view.addSubview(self.dropDownView)
        self.dropDownView.snapToSuperview()

        self.dropDownView.alpha = 0.0
    }

    func manualEntryButtonTapped() {
        print("DropDownViewController -- " + #function)
        let manualEntryViewController = ManualEntryViewController()
        self.present(manualEntryViewController, animated: true, completion: nil)
    }

    func scanReceiptButtonTapped() {
        print(#function)
        self.openCameraButton(self.dropDownView.scanReceiptButton)
    }

    func openCameraButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }

}
