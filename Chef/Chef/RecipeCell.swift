import UIKit
import SnapKit
import Kingfisher

class RecipeCell: UICollectionViewCell {

    weak var delegate: RecipeCellDelegate?
    var imageView: UIImageView!
    var nameLabel: UILabel!
    var heartButton: UIButton!

    var recipe: Recipe! {
        didSet {
            self.didSetRecipe()
        }
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

        self.imageView = UIImageView()
        self.addSubview(imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(5)
            make.width.equalToSuperview().offset(-10)
            make.height.equalTo(self.imageView.snp.width)
        }

        self.nameLabel = {
            let lb = UILabel()
            lb.numberOfLines = 0
            lb.font = Fonts.medium16
            lb.textColor = Colors.flatironBlue
            return lb
        }()
        self.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }

        self.heartButton = {
            let heartImage = UIImage(named: "heart")!.withRenderingMode(.alwaysTemplate)
            let fb = UIButton()
            fb.setImage(heartImage, for: .normal)
            fb.backgroundColor = .white
            fb.addTarget(self, action: #selector(tapHeart), for: .touchUpInside)
            return fb
        }()
        self.addSubview(self.heartButton)
        self.heartButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
        }
    }

    private func didSetRecipe() {
        let url = URL(string: recipe.imageLink)
        self.imageView.kf.setImage(with: url,
                                   placeholder: nil,
                                   options: [],
                                   progressBlock: nil,
                                   completionHandler: nil)

        self.nameLabel.text = self.recipe.title
        
        self.heartButton.imageView?.tintColor = self.recipe.isFavorite ? Colors.flatironBlue : .lightGray
    }


    // MARK: - Actions

    func tapHeart() {
        print("RecipeCell -- \(#function)")
        self.recipe.isFavorite = !self.recipe.isFavorite
        self.animateHeart()
        self.delegate?.heartButtonTapped(self)
    }

    private func animateHeart() {
        if self.recipe.isFavorite {
            UIView.animate(withDuration: 1.5,
                           delay: 0,
                           usingSpringWithDamping: 30,
                           initialSpringVelocity: 10,
                           options: [.allowUserInteraction],
                           animations: {
                self.heartButton.imageView?.tintColor = Colors.flatironBlue
                self.heartButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.heartButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        } else {
            UIView.animate(withDuration: 1.5,
                           delay: 0,
                           usingSpringWithDamping: 30,
                           initialSpringVelocity: 10,
                           options: [.allowUserInteraction],
                           animations: {
                self.heartButton.imageView?.tintColor = .lightGray
                self.heartButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.heartButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
    }

}
