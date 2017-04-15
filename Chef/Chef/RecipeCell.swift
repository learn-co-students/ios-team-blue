import UIKit
import SnapKit

class RecipeCell: UICollectionViewCell {

    var imgView: UIImageView!
    var nameLabel: UILabel!
    var favoriteButton: UIButton!
    var isFavorited: Bool = false

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

        self.imgView = UIImageView()

        self.addSubview(imgView)

        self.imgView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(5)
            make.width.equalToSuperview().offset(-10)
            make.height.equalTo(self.imgView.snp.width)
        }

        self.nameLabel = {
            let lb = UILabel()
            lb.numberOfLines = 0
            lb.font = UIFont(name: Style.regular, size: 14)
            lb.textColor = Style.flatironBlue
            return lb
        }()

        self.addSubview(nameLabel)

        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imgView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }

        self.favoriteButton = {
            let heartImage = UIImage(named: "heart")!.withRenderingMode(.alwaysTemplate)
            let fb = UIButton()
            fb.setImage(heartImage, for: .normal)
            fb.imageView?.tintColor = .lightGray
            fb.backgroundColor = .white
            return fb
        }()

        self.addSubview(favoriteButton)

        self.favoriteButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
        }

        self.favoriteButton.addTarget(self, action: #selector(favorited), for: .touchUpInside)
    }

    func favorited(sender: UIButton) {
        self.isFavorited = self.isFavorited ? false : true

        if self.isFavorited {
            UIView.animate(withDuration: 1.5,
                           delay: 0,
                           usingSpringWithDamping: 30,
                           initialSpringVelocity: 10,
                           options: [.allowUserInteraction],
                           animations: {
                self.favoriteButton.imageView?.tintColor = Style.flatironBlue
                self.favoriteButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.favoriteButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        } else {
            UIView.animate(withDuration: 1.5,
                           delay: 0,
                           usingSpringWithDamping: 30,
                           initialSpringVelocity: 10,
                           options: [.allowUserInteraction],
                           animations: {
                self.favoriteButton.imageView?.tintColor = .lightGray
                self.favoriteButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.favoriteButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
    }

}
