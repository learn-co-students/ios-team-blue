import UIKit
import SnapKit

class DropDownView: UIView {

    weak var delegate: DropDrownViewDelegate!
    var manualEntryButton: UIButton!
//    var scanReceiptButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.backgroundColor = .clear
        self.createUI()
        self.constrainUI()
    }

    private func createUI() {
        self.manualEntryButton = {
            let meb = UIButton()
            meb.backgroundColor = Colors.flatironBlue
            meb.layer.cornerRadius = 1
            meb.layer.borderColor = UIColor.white.cgColor
            meb.layer.borderWidth = 1
            meb.titleLabel?.textColor = .white
            meb.setTitle("Manual Entry", for: .normal)
            meb.titleLabel?.font = Fonts.heavy16
            meb.addTarget(self, action: #selector(manualEntryButtonTapped), for: .touchUpInside)
            return meb
        }()
        self.addSubview(self.manualEntryButton)

//        self.scanReceiptButton = {
//            let srb = UIButton()
//            srb.backgroundColor = Colors.flatironBlue
//            srb.layer.cornerRadius = 8
//            srb.layer.borderColor = UIColor.white.cgColor
//            srb.layer.borderWidth = 1
//            srb.titleLabel?.textColor = UIColor.white
//            srb.setTitle("Scan Receipt", for: .normal)
//            srb.titleLabel?.font = Fonts.heavy16
//            srb.addTarget(self, action: #selector(scanReceiptButtonTapped), for: .touchUpInside)
//            return srb
//        }()
//        self.addSubview(self.scanReceiptButton)
    }

    private func constrainUI() {
//        self.manualEntryButton.snp.makeConstraints { make in
//            make.right.equalToSuperview().offset(-4)
//            make.top.equalToSuperview().offset(18)
//            make.width.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.5)
//        }
        self.manualEntryButton.snapToSuperview()

//        self.scanReceiptButton.snp.makeConstraints { make in
//            make.top.equalTo(self.manualEntryButton.snp.bottom).offset(1)
//            make.right.equalToSuperview()
//            make.width.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.5)
//        }
    }


    // MARK: - Delegate

    func manualEntryButtonTapped() {
        self.delegate.manualEntryButtonTapped()
    }

//    func scanReceiptButtonTapped() {
//        self.delegate.scanReceiptButtonTapped()
//    }

}
