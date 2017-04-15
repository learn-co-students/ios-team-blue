import UIKit

class ScanReceiptView: UIView {

    var saveReceiptButton: UIButton!
    var rescanReceiptButton: UIButton!
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

    }

    func createBackground() {
        self.backgroundColor = UIColor.white
    }

    func createSaveReceiptButton() {

    }

    func createrescanReceiptButton() {

    }

}
