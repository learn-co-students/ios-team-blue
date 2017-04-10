import UIKit
import SnapKit

class RecipeCell: UITableViewCell {

    var imgView: UIImageView!
    var nameLabel: UILabel!
    var favoriteButton: UIButton!

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

        self.favoriteButton = UIButton()
        favoriteButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        self.addSubview(favoriteButton)

        self.favoriteButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(self.imgView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
        }

        favoriteButton.addTarget(self, action: #selector(favorited), for: .touchUpInside)

    }

    @IBAction func favorited(sender: UIButton) {
        favoriteButton = sender

        if sender.isSelected{
            UIView.animate(withDuration: 1.0, animations:{
                self.favoriteButton.setImage(#imageLiteral(resourceName: "Filled Heart"), for: .normal)
                print("RED")
                sender.isSelected = false
            })
        } else {
            UIView.animate(withDuration: 1.0, animations:{
                self.favoriteButton.backgroundColor = UIColor.white
                self.favoriteButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
                print("WHITE")
                sender.isSelected = true
            })
        }

    }

}
