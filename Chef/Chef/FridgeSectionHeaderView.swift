import UIKit

class FridgeSectionHeaderView: UIView {

    static let height: Int = 30

    lazy var label: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = Fonts.medium16
        return l
    }()

    convenience init() {
        self.init(frame: CGRect.zero)
        self.commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.backgroundColor = Colors.flatironBlue

        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
}
