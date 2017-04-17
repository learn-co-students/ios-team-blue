import UIKit
import AVFoundation
import MobileCoreServices
import Photos


class ScanReceiptViewController: UIViewController, ScanReceiptViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var scanReceiptView: ScanReceiptView!
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
    }

    func openLibraryButtonTapped() {
        useCameraRoll(scanReceiptView.openLibraryButton)
        print(#function)
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

    func openCameraButton(_ sender: UIButton) {
        //scanReceiptView.openLibraryButton = sender
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
        newMedia = true
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

    


}
