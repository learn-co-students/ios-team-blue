import UIKit

class FoodEntryTextField: UITextField {

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
        self.keyboardType = .default
        self.textColor = Colors.flatironBlue
        self.layer.cornerRadius = 1
        self.layer.borderColor = Colors.flatironBlue.cgColor
        self.layer.borderWidth = 1
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

}
