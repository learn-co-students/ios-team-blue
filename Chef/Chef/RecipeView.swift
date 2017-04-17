import UIKit

class RecipeView: UIView {

    var imageView: UIImageView!
    var navBarHeight: CGFloat = 8 {
        didSet {
            self.constrain()
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

        self.imageView = {
            let iv = UIImageView()
            iv.image = UIImage(named: "bird")!
            return iv
        }()

        self.addSubview(self.imageView)
    }

    func constrain() {
        let height = UIApplication.shared.statusBarFrame.height + self.navBarHeight + 8

        self.imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(height)
            make.height.width.equalTo(180)
        }
    }
    
}
