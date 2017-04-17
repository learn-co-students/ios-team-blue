import UIKit
import SnapKit


class DropDownView: UIView {

    weak var delegate: DropDrownViewDelegate!
    var manualEntryButton: UIButton!
    var scanReceiptButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.createManualEntryButton()
        self.createScanReceiptButton()
        self.backgroundColor = UIColor.white
    }

    func createManualEntryButton() {
        self.manualEntryButton = {
            let me = UIButton()
            me.backgroundColor = Style.flatironBlue
            me.titleLabel?.textColor = UIColor.white
            me.setTitle("Manual Entry", for: .normal)
            me.titleLabel?.font = UIFont(name: Style.bold, size: 18)
            me.layer.cornerRadius = 8
            me.addTarget(self, action: #selector(manualEntryButtonTapped), for: .touchUpInside)
            return me
        }()

        self.addSubview(self.manualEntryButton)
        self.manualEntryButton.snp.makeConstraints { make in
            make.left.equalToSuperview
            make.top.equalToSuperview().offset(18)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }

    func createScanReceiptButton() {
        self.scanReceiptButton = {
            let sr = UIButton()
            sr.backgroundColor = Style.flatironBlue
            sr.titleLabel?.textColor = UIColor.white
            sr.setTitle("Scan Receipt", for: .normal)
            sr.titleLabel?.font = UIFont(name: Style.bold, size: 18)
            sr.layer.cornerRadius = 8
            sr.addTarget(self, action: #selector(scanReceiptButtonTapped), for: .touchUpInside)
            return sr
        }()

        self.addSubview(self.scanReceiptButton)
        self.scanReceiptButton.snp.makeConstraints { make in
            make.top.equalTo(self.manualEntryButton.snp.bottom).offset(1)
            make.left.equalToSuperview
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }


    // MARK: - Delegate

    func manualEntryButtonTapped() {
        self.delegate.manualEntryButtonTapped()
    }

    func scanReceiptButtonTapped() {
        self.delegate.scanReceiptButtonTapped()
    }

}
