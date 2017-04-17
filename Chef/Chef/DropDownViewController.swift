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

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
    UIImageWriteToSavedPhotosAlbum(pickedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

    dismiss(animated: true, completion: nil)
    }
    }

    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }

}
