import UIKit

class LoginTextField: UITextField {

    init() {
        super.init(frame: .zero)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 2
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = .zero
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let paddingLeftRight: CGFloat = 7

        let x = bounds.origin.x + paddingLeftRight
        let y = bounds.origin.y
        let width = bounds.size.width - (2 * paddingLeftRight)
        let height = bounds.size.height

        return CGRect(x: x, y: y, width: width, height: height)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
}
