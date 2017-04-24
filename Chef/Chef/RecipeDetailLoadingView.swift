import UIKit

class RecipeDetailLoadingView: UIView {

    static let height = 200

    lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let bv = UIVisualEffectView(effect: blurEffect)
        return bv
    }()

    lazy var indicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        return ind
    }()

    convenience init() {
        self.init(frame: .zero)
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
        self.constrainUI()
    }

    private func constrainUI() {
        self.addSubview(self.blurView)
        self.addSubview(self.indicator)

        self.blurView.snapToSuperview()

        self.indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
