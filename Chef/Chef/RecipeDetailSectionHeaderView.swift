import UIKit

class RecipeDetailSectionHeaderView: UIView {

    static let height: Int = 20

    lazy var label: UILabel = {
        let l = UILabel()
        l.textColor = Colors.flatironBlue
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
        self.backgroundColor = .white

        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
        }
    }

}
