import UIKit
import MobileCoreServices
import Photos


class ScanReceiptViewController: UIViewController, ScanReceiptViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var scanReceiptView: ScanReceiptView!
    var dropDownView: DropDownView!
    var newMedia: Bool?



    override func viewDidLoad() {
        super.viewDidLoad()
        self.scanReceiptView = ScanReceiptView()
        self.scanReceiptView.delegate = self
        self.view.addSubview(self.scanReceiptView)
        self.scanReceiptView.snapToSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func saveReceiptButtonTapped() {
        print(#function)
        //firebase image saving code goes here
    }

    func openLibraryButtonTapped() {
        useCameraRoll(scanReceiptView.openLibraryButton)
    }

    func useCameraRoll(_ sender: UIButton) {
        scanReceiptView.openLibraryButton = sender
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = false
        }
    }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        if mediaType.isEqual(to: kUTTypeImage as String) {
            guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { print("NOPE!") ; return }
            scanReceiptView.captureImageView.image =  image
            //imageView.image = image
            if (newMedia == true) { UIImageWriteToSavedPhotosAlbum(image, self,  #selector(ScanReceiptViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }

    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer) {
        if error != nil {
            let alert = UIAlertController(title: "Save Failed", message: "Failed to save image",
                                          preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true,
                         completion: nil)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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

   /* func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerEditedImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }*/


    


}
