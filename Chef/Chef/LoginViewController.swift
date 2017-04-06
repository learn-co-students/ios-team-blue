import UIKit
import SnapKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    var usernameTextField: LoginTextField!
    var passwordTextField: LoginTextField!
    var loginSignupButton: UIButton!
    var switchButton: UIButton!
    var userIsSigningUp: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }

    func signUp() {
        guard let email = self.usernameTextField.text, let password = self.passwordTextField.text else {
            return
        }
        FirebaseManager.signUp(email: email, password: password) { success in
            if success {
                self.logIn()
            } else {
                self.shakeTextFields()
            }
        }
    }

    func logIn() {
        guard let email = self.usernameTextField.text, let password = self.passwordTextField.text else {
            return
        }
        FirebaseManager.login(email: email, password: password) { success in
            if success {
                // create user and save to data store as current user
                self.pushToTabBarController()
            } else {
                self.shakeTextFields()
            }
        }
    }

    func loginSignupButtonTapped() {
        if userIsSigningUp {
            self.signUp()
        } else {
            self.logIn()
        }
    }

    func switchButtonTapped() {
        self.userIsSigningUp = self.userIsSigningUp ? false : true

        print(self.userIsSigningUp)

        self.loginSignupButton.titleLabel?.alpha = 0.0
        self.switchButton.titleLabel?.alpha = 0.0

        if self.userIsSigningUp {
            self.loginSignupButton.setTitle("Sign Up", for: .normal)
            self.switchButton.setTitle("Login", for: .normal)
        } else {
            self.loginSignupButton.setTitle("Login", for: .normal)
            self.switchButton.setTitle("Sign Up", for: .normal)
        }

        UIView.animate(withDuration: 0.6) {
            self.loginSignupButton.titleLabel?.alpha = 1.0
            self.switchButton.titleLabel?.alpha = 1.0
        }
    }

    func shakeTextFields() {
        self.usernameTextField.shake()
        self.passwordTextField.shake()
    }


    // MARK: - Navigation

    func pushToTabBarController() {
        let tabBarController = TabBarController()
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }


    // MARK: - UI

    func createUI() {
        self.createBackgroundImage()
        self.createHeaderText()
        self.createUsernameTextField()
        self.createPasswordField()
        self.createLoginSignupButton()
        self.createSwitchButton()
    }

    func createBackgroundImage() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "food-background")

        self.view.addSubview(imageView)

        imageView.snp.makeConstraints { (make) in
            make.top.left.height.width.equalToSuperview()
        }
    }

    func createHeaderText() {
        let headerLabel = UILabel()
        headerLabel.text = "Chef"
        headerLabel.textColor = .white
        headerLabel.font = UIFont(name: "Avenir-Medium", size: 48)

        self.view.addSubview(headerLabel)

        headerLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(75)
        }
    }

    func createUsernameTextField() {
        self.usernameTextField = LoginTextField()
        self.usernameTextField.keyboardType = .emailAddress

        self.view.addSubview(self.usernameTextField)

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

        self.view.addSubview(self.passwordTextField)

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

        self.view.addSubview(self.loginSignupButton)

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

        self.view.addSubview(self.switchButton)

        self.switchButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-12)
        }

        self.switchButton.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
    }
    
}
