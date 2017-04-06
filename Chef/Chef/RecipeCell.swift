import UIKit
import SnapKit

class RecipeCell: UITableViewCell {

    var imgView: UIImageView!
    var nameLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    func commonInit() {
        self.imgView = UIImageView()
        self.addSubview(imgView)

        self.imgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(120)
        }

        self.nameLabel = UILabel()
        self.addSubview(nameLabel)

        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(self.imgView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
        }
    }

}
