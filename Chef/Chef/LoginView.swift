import UIKit
import SnapKit

class LoginView: UIView {

    weak var delegate: LoginViewDelegate!
    var blurredView: UIVisualEffectView!
    var headerLabel: UILabel!
    var usernameTextField: LoginTextField!
    var passwordTextField: LoginTextField!
    var loginSignupButton: UIButton!
    var switchButton: UIButton!
    var activityIndicator: UIActivityIndicatorView!
    var isLoading: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.createBackgroundImage()
        self.createBlurredView()
        self.createHeaderLabel()
        self.createUsernameTextField()
        self.createPasswordTextField()
        self.createLoginSignupButton()
        self.createSwitchButton()
        self.createActivityIndicator()
        self.createGestureRecognizer()
    }


    // MARK: - Actions

    func shakeTextFields() {
        self.usernameTextField.shake()
        self.passwordTextField.shake()
    }

    func hideKeyboard() {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }

    func toggleLoading() {
        self.isLoading = self.isLoading ? false : true

        if self.isLoading {
            self.activityIndicator.startAnimating()
            self.hideKeyboard()

            UIView.animate(withDuration: 0.4, animations: {
                self.usernameTextField.alpha = 0.0
                self.passwordTextField.alpha = 0.0
                self.loginSignupButton.alpha = 0.0
                self.switchButton.alpha = 0.0
                self.blurredView.alpha = 1.0
                self.activityIndicator.alpha = 1.0
            })
        } else {
            self.activityIndicator.stopAnimating()

            UIView.animate(withDuration: 0.4, animations: {
                self.usernameTextField.alpha = 1.0
                self.passwordTextField.alpha = 1.0
                self.loginSignupButton.alpha = 1.0
                self.switchButton.alpha = 1.0
                self.blurredView.alpha = 0.0
                self.activityIndicator.alpha = 0.0
            })
        }
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

    func backgroundDoubleTapped() {     // MARK: - Tmp
        self.delegate.backgroundDoubleTapped()
    }


    // MARK: - UI

    func createBackgroundImage() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "food-background")

        self.addSubview(imageView)
        imageView.snapToSuperview()
    }

    func createBlurredView() {
        self.blurredView = {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
            let bv = UIVisualEffectView(effect: blurEffect)
            bv.alpha = 0.0
            return bv
        }()

        self.addSubview(self.blurredView)
        self.blurredView.snapToSuperview()
    }

    func createHeaderLabel() {
        self.headerLabel = {
            let hl = UILabel()
            hl.text = "Chef"
            hl.textColor = .white
            hl.font = Fonts.medium48
            return hl
        }()

        self.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(75)
        }
    }

    func createUsernameTextField() {
        self.usernameTextField = LoginTextField()
        self.usernameTextField.keyboardType = .emailAddress

        self.addSubview(self.usernameTextField)
        self.usernameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.667)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(28)
        }
    }

    func createPasswordTextField() {
        self.passwordTextField = LoginTextField()
        self.passwordTextField.isSecureTextEntry = true

        self.addSubview(self.passwordTextField)
        self.passwordTextField.snp.makeConstraints { make in
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
            lb.titleLabel?.font = Fonts.heavy18
            lb.layer.cornerRadius = 5
            lb.addTarget(self, action: #selector(loginSignupButtonTapped), for: .touchUpInside)
            return lb
        }()

        self.addSubview(self.loginSignupButton)
        self.loginSignupButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.333)
        }
    }

    func createSwitchButton() {
        self.switchButton = {
            let sb = UIButton()
            sb.backgroundColor = .clear
            sb.setTitle("Sign Up", for: .normal)
            sb.titleLabel?.textColor = .white
            sb.titleLabel?.font = Fonts.heavy16
            sb.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
            return sb
        }()

        self.addSubview(self.switchButton)
        self.switchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-12)
        }
    }

    func createActivityIndicator() {
        self.activityIndicator = {
            let ai = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            ai.alpha = 0.0
            return ai
        }()

        self.addSubview(self.activityIndicator)
        self.activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.667)
        }
    }

    func createGestureRecognizer() {
        let tap: UITapGestureRecognizer = {
            let tgr = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
            tgr.numberOfTapsRequired = 1
            return tgr
        }()

        // MARK: - Tmp
        let doubleTap: UITapGestureRecognizer = {
            let tgr = UITapGestureRecognizer(target: self, action: #selector(backgroundDoubleTapped))
            tgr.numberOfTapsRequired = 2
            return tgr
        }()

        tap.require(toFail: doubleTap)

        self.addGestureRecognizer(tap)
        self.addGestureRecognizer(doubleTap)
    }

}
