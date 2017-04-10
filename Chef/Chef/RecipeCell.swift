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
            UIView.animate(withDuration: 2.0,  delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10,
                           options: .allowUserInteraction,  animations:{
                            self.favoriteButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            self.favoriteButton.setImage(#imageLiteral(resourceName: "Filled Heart"), for: .normal)
                            print("RED")
                            self.favoriteButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                            sender.isSelected = false
            })

        } else {
            UIView.animate(withDuration: 2.0,  delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10,
                           options: .allowUserInteraction, animations:{
                self.favoriteButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.favoriteButton.backgroundColor = UIColor.white
                self.favoriteButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
                print("WHITE")
                self.favoriteButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                sender.isSelected = true
            })
        }

    }

}
