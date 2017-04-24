import UIKit

class RecipeDetailCell: UITableViewCell {

    lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.medium16
        return label
    }()

    lazy var numLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.medium16
        return label
    }()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.selectionStyle = .none

        self.addSubview(self.numLabel)
        self.numLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
        }

        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

}
