import UIKit
import SnapKit
import Kingfisher

class RecipeCell: UICollectionViewCell {

    weak var delegate: RecipeCellDelegate?
    weak var imageViewDelegate: RecipeCellImageViewDelegate? {
        didSet {
            if let foodImage = self.imageView.image {
                self.imageViewDelegate?.didReceiveImage(foodImage)
            }
        }
    }
    var topContainerView: UIView!
    var bottomContainerView: UIView!
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
        self.createUI()
        self.constrainUI()
    }

    private func createUI() {
        let containerSize = CGSize(width: self.bounds.width, height: self.bounds.height/2)

        self.topContainerView = {
            let origin = self.bounds.origin
            let frame = CGRect(origin: origin, size: containerSize)
            let view = UIView(frame: frame)
            return view
        }()
        self.addSubview(self.topContainerView)

        self.bottomContainerView = {
            let x = self.bounds.origin.x
            let y = self.bounds.height / 2
            let origin = CGPoint(x: x, y: y)
            let frame = CGRect(origin: origin, size: containerSize)
            let view = UIView(frame: frame)
            return view
        }()
        self.addSubview(self.bottomContainerView)

        self.imageView = UIImageView()
        self.topContainerView.addSubview(self.imageView)

        self.nameLabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.font = Fonts.medium16
            label.textColor = Colors.flatironBlue
            return label
        }()
        self.bottomContainerView.addSubview(nameLabel)

        self.heartButton = {
            let heartImage = UIImage(named: "heart")!.withRenderingMode(.alwaysTemplate)
            let button = UIButton()
            button.setImage(heartImage, for: .normal)
            button.backgroundColor = .white
            button.addTarget(self, action: #selector(tapHeart), for: .touchUpInside)
            return button
        }()
        self.bottomContainerView.addSubview(self.heartButton)
    }

    private func constrainUI() {
        self.imageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(5)
            make.width.equalToSuperview().offset(-10)
            make.height.equalTo(self.imageView.snp.width)
        }

        self.nameLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(8)
            make.width.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.heartButton.snp.top).offset(-8)
        }

        self.heartButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(self.heartButton.snp.width)
        }
    }

    private func didSetRecipe() {
        let url = URL(string: self.recipe.imageLink)
        self.imageView.kf.setImage(with: url, placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)

        self.nameLabel.text = self.recipe.title
        
        self.heartButton.imageView?.tintColor = self.recipe.isFavorite ? Colors.flatironBlue : .lightGray
    }


    // MARK: - Actions

    func tapHeart() {
        self.recipe.isFavorite = !self.recipe.isFavorite
        self.animateHeart()
        self.delegate?.heartButtonTapped(self)
    }

    private func animateHeart() {
        if self.recipe.isFavorite {
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 30, initialSpringVelocity: 10, options: [.allowUserInteraction], animations: {
                self.heartButton.imageView?.tintColor = Colors.flatironBlue
                self.heartButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.heartButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        } else {
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 30, initialSpringVelocity: 10, options: [.allowUserInteraction], animations: {
                self.heartButton.imageView?.tintColor = .lightGray
                self.heartButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.heartButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
    }

}
