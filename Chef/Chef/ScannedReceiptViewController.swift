import UIKit
import SnapKit

class ScannedReceiptViewController: UIViewController {

    var urlToLastPhoto: URL! = {
        return DropDownViewController.getDocumentsDirectory()
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
