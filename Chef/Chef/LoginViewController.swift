import UIKit
import SnapKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    var usernameTextField: LoginTextField!
    var passwordTextField: LoginTextField!
    var userIsSigningUp: Bool = true    // temporarily setting to true, should initially be false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

        GoogleVision.getDescriptionfor("https://fizzleblog.files.wordpress.com/2010/12/grocery-receipt-2.jpg?w=756") { (json) in
            let text = GoogleVision.clean(text: json)
            print("\n\n\n\nCLEAN RECEIPT DATA")
            print(text)
        }
    }

    func buttonTapped() {
        if userIsSigningUp {
            self.signUp()
        } else {
            self.logIn()
        }
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
                self.pushToTabBarController()
            } else {
                self.shakeTextFields()
            }
        }
    }

    func pushToTabBarController() {
        print(#function)
    }

}


extension LoginViewController {

    func createUI() {
        self.createBackgroundImage()
        self.createHeaderText()
        self.createUsernameTextField()
        self.createPasswordField()
        self.createButton()
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

    func createButton() {
        let loginButton: UIButton = {
            let lb = UIButton()
            lb.backgroundColor = .white
            lb.setTitle("Login", for: .normal)
            lb.setTitleColor(.black, for: .normal)
            lb.layer.cornerRadius = 5
            return lb
        }()

        self.view.addSubview(loginButton)

        loginButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func shakeTextFields() {
        self.usernameTextField.shake()
        self.passwordTextField.shake()
    }
    
}
