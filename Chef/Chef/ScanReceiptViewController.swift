import UIKit

class ScanReceiptViewController: UIViewController, ScanReceiptViewDelegate {

    var scanReceiptView: ScanReceiptView!

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

    func rescanReceiptButtonTapped() {
        print(#function)
    }
    


}
