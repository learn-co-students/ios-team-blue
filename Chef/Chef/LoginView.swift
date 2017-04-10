import UIKit
import SnapKit

class LoginView: UIView {

    weak var delegate: LoginViewDelegate!
    var usernameTextField: LoginTextField!
    var passwordTextField: LoginTextField!
    var loginSignupButton: UIButton!
    var switchButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    func commonInit() {
        self.createBackgroundImage()
        self.createHeaderText()
        self.createUsernameTextField()
        self.createPasswordField()
        self.createLoginSignupButton()
        self.createSwitchButton()
        self.createGestureRecognizer()
    }

    func createBackgroundImage() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "food-background")

        self.addSubview(imageView)

        imageView.snp.makeConstraints { (make) in
            make.top.left.height.width.equalToSuperview()
        }
    }

    func createHeaderText() {
        let headerLabel = UILabel()
        headerLabel.text = "Chef"
        headerLabel.textColor = .white
        headerLabel.font = UIFont(name: "Avenir-Medium", size: 48)

        self.addSubview(headerLabel)

        headerLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(75)
        }
    }

    func createUsernameTextField() {
        self.usernameTextField = LoginTextField()
        self.usernameTextField.keyboardType = .emailAddress

        self.addSubview(self.usernameTextField)

        self.usernameTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.66)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(28)
        }
    }

    func createPasswordField() {
        self.passwordTextField = LoginTextField()
        self.passwordTextField.isSecureTextEntry = true

        self.addSubview(self.passwordTextField)

        self.passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.usernameTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(28)
        }
    }

    func createLoginSignupButton() {
        self.loginSignupButton = {
            let lb = UIButton()
            lb.backgroundColor = .white
            lb.setTitle("Login", for: .normal)
            lb.setTitleColor(.black, for: .normal)
            lb.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
            lb.layer.cornerRadius = 5
            return lb
        }()

        self.addSubview(self.loginSignupButton)

        self.loginSignupButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        self.loginSignupButton.addTarget(self, action: #selector(loginSignupButtonTapped), for: .touchUpInside)
    }

    func createSwitchButton() {
        self.switchButton = {
            let sb = UIButton()
            sb.backgroundColor = .clear
            sb.setTitle("Sign Up", for: .normal)
            sb.titleLabel?.textColor = .white
            sb.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 16)
            return sb
        }()

        self.addSubview(self.switchButton)

        self.switchButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-12)
        }

        self.switchButton.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
    }

    func createGestureRecognizer() {
        let tapGesture: UITapGestureRecognizer = {
            let tgr = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
            tgr.numberOfTapsRequired = 1
            return tgr
        }()

        self.addGestureRecognizer(tapGesture)
    }


    // MARK: - Delegate

    func backgroundTapped() {
        self.delegate.backgroundTapped()
    }

    func loginSignupButtonTapped() {
        self.delegate.loginSignupButtonTapped()
    }

    func switchButtonTapped() {
        self.delegate.switchButtonTapped()
    }

}
