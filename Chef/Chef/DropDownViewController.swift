import UIKit
import MobileCoreServices
import Photos

class DropDownViewController: UIViewController, DropDrownViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    var dropDownView: DropDownView!
    var imagePicker: UIImagePickerController!
    var base64img = String()
    var scannedReceiptVC: ScannedReceiptViewController!
    var parsedIngredients = [String]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let xcoordinate = view.bounds.width - 150
        let menuStart = CGRect(x: xcoordinate, y: -160, width: 150, height: 80)
        self.dropDownView = DropDownView(frame: menuStart)
        self.dropDownView.delegate = self
        self.view.addSubview(self.dropDownView)
    }

    func setupDropdown() {
        dropDownView.translatesAutoresizingMaskIntoConstraints = false
        dropDownView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        dropDownView.widthAnchor.constraint(equalTo: view.widthAnchor , multiplier: 0.4).isActive = true
        dropDownView.center.y -= self.view.bounds.height
        dropDownView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    func manualEntryButtonTapped() {
        let manualEntryViewController = ManualEntryViewController()
        self.present(manualEntryViewController, animated: true, completion: nil)
    }

    func scanReceiptButtonTapped() {
        self.openCameraButton(self.dropDownView.scanReceiptButton)
        print("scanReceiptButtonTapped tapped")
    }

    func openCameraButton(_ sender: UIButton) {
        self.imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            base64img = base64EncodeImage(image)
            setParsedIngredients()
        }
    }

    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    private func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata  = UIImagePNGRepresentation(image)
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

    private func setParsedIngredients() {
        GoogleVisionAPIClient.getDescriptionfor(base64img) { (ingredientsList) in
            DispatchQueue.main.async {
                self.parsedIngredients = ingredientsList
                self.scannedReceiptVC = ScannedReceiptViewController()
                self.scannedReceiptVC.parsedIngredients = self.parsedIngredients
                self.imagePicker.dismiss(animated: true) {
                    self.navigationController?.pushViewController(self.scannedReceiptVC, animated: true)
                }
            }
        }
    }
    
}
