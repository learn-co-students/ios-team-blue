import UIKit
import MobileCoreServices
import Photos

class DropDownViewController: UIViewController, DropDrownViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    var dropDownView: DropDownView!
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dropDownView = DropDownView()
        self.dropDownView.delegate = self

        self.view.addSubview(self.dropDownView)
        self.dropDownView.snapToSuperview()

        self.dropDownView.alpha = 0.0
    }

    func manualEntryButtonTapped() {
        let manualEntryViewController = ManualEntryViewController()
        self.present(manualEntryViewController, animated: true, completion: nil)
    }

    func scanReceiptButtonTapped() {
        self.openCameraButton(self.dropDownView.scanReceiptButton)
    }

    func openCameraButton(_ sender: UIButton) {
        print(#function)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }


//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//            let mediaType = info[UIImagePickerControllerMediaType] as! NSString
//            if mediaType.isEqual(to: kUTTypeImage as String) {
//                guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { print("NOPE!") ; return }
//                scanReceiptView.captureImageView.image =  image
//                //imageView.image = image
//                if (newMedia == true) { UIImageWriteToSavedPhotosAlbum(image, self,  #selector(ScanReceiptViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
//                }
//                self.dismiss(animated: true, completion: nil)
//            }
//        }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            //imageView.image = image

            let imageName = UUID().uuidString
            let imagePath = DropDownViewController.getDocumentsDirectory().appendingPathComponent(imageName)

            if let jpegData = UIImageJPEGRepresentation(image, 80) {
                try? jpegData.write(to: imagePath)
            }

            picker.dismiss(animated: true) {
                print(#function)
                self.presentScannedReceiptViewController()
            }


            
        }
    }



//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
//        let imageName = UUID().uuidString
//        let imagePath = DropDownViewController.getDocumentsDirectory().appendingPathComponent(imageName)
//
//        if let jpegData = UIImageJPEGRepresentation(image, 80) {
//            try? jpegData.write(to: imagePath)
//        }
//
//        picker.dismiss(animated: true) {
//            print(#function)
//        }
//    }

    static func getDocumentsDirectory() -> URL {
        print(#function)
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print(#function)
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

    func presentScannedReceiptViewController() {
    let scannedReceiptViewController = ScannedReceiptViewController()
    self.present(scannedReceiptViewController, animated: true, completion: nil)
    }
    
    
    
}
