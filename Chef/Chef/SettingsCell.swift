import UIKit

class SettingsCell: UICollectionViewCell {

    var label: UILabel!

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

        self.label = {
            let lb = UILabel()
            lb.font = UIFont(name: Style.regular, size: 14)
            return lb
        }()

        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
