import UIKit

class RecipeView: UIView {

    var imageView: UIImageView!
    var textView: UITextView!
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

        self.textView = {
            let tv = UITextView(frame: .zero)
            return tv
        }()

        self.addSubview(self.textView)

        self.constrain()
    }

    func constrain() {
        let height = UIApplication.shared.statusBarFrame.height + self.navBarHeight + 8

        self.imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(height)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(180)
        }

        self.textView.snp.makeConstraints { make in
            //            make.top.equalToSuperview().offset(200)
            make.centerX.centerY.width.height.equalToSuperview()
        }
    }
    
}
