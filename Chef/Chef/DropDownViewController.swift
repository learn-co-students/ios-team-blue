import UIKit
import MobileCoreServices
import Photos

class DropDownViewController: UIViewController, DropDrownViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    var dropDownView: DropDownView!
    var imagePicker: UIImagePickerController!
    var imageData = Data()
    var base64img = String()
    var scannedReceiptVC: ScannedReceiptViewController!
    var parsedIngredients = [String]()


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
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let imageName = UUID().uuidString
            let imagePath = DropDownViewController.getDocumentsDirectory().appendingPathComponent(imageName)

            if let jpegData = UIImageJPEGRepresentation(image, 80) {
                try? jpegData.write(to: imagePath)
                self.imageData = jpegData
                print("THE DATA IS: \(imageData)")

                base64img = base64EncodeImage(image)
                setParsedIngredients()
            }

        }
    }

    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    //From S.O.
    private func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata  = UIImagePNGRepresentation(image)

        // Resize the image if it exceeds the 2MB API limit
        if ((imagedata?.count)! > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imagedata = resizeImage(newSize, image: image)
        }

        return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
    }

    private func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = UIImagePNGRepresentation(newImage!)
        UIGraphicsEndImageContext()
        return resizedImage!
    }

    func setParsedIngredients() {
        GoogleVisionAPIClient.getDescriptionfor(base64img) { (ingredientsList) in
            DispatchQueue.main.async {
                print("HERE WE ARE!!!", #function)
                self.parsedIngredients = ingredientsList
                print(ingredientsList)
                self.scannedReceiptVC.parsedIngredients = self.parsedIngredients
                self.scannedReceiptVC.tableView.reloadData()
                self.dismiss(animated: true) {
                    self.presentScannedReceiptViewController()
                }
            }
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

    func presentScannedReceiptViewController() {
        let scannedReceiptViewController = ScannedReceiptViewController()
        self.present(scannedReceiptViewController, animated: true, completion: nil)
    }
    
    
    
}
