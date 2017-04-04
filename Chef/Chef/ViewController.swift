import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }

    func signUpButtonTapped() {
        guard let email = self.usernameTextField.text, let password = self.passwordTextField.text else {
            return
        }
        FirebaseManager.signUp(email: email, password: password, completion: nil)
    }

}


extension ViewController {

    func createUI() {
        self.createBackgroundImage()
        self.createUsernameTextField()
        self.createPasswordField()
        self.createButton()
    }

    func createUsernameTextField() {
        self.usernameTextField = {
            let tf = UITextField()
            tf.backgroundColor = .white
            tf.backgroundColor = .white
            tf.layer.shadowColor = UIColor.lightGray.cgColor
            tf.layer.shadowOpacity = 2
            tf.layer.shadowRadius = 5
            tf.layer.shadowOffset = CGSize.zero
            tf.autocapitalizationType = .none
            tf.autocorrectionType = .no
            return tf
        }()

        self.view.addSubview(self.usernameTextField)

        self.usernameTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.66)
        }
    }

    func createPasswordField() {
        self.passwordTextField = {
            let tf = UITextField()
            tf.backgroundColor = .white
            tf.autocapitalizationType = .none
            tf.isSecureTextEntry = true
            return tf
        }()

        self.view.addSubview(self.passwordTextField)

        self.passwordTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.usernameTextField.snp.bottom).offset(20)
        }
    }

    func createBackgroundImage() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "food-background")

        self.view.addSubview(imageView)

        imageView.snp.makeConstraints { (make) in
            make.top.left.height.width.equalToSuperview()
        }
    }

    func createButton() {
        self.loginButton = {
            let lb = UIButton()
            lb.backgroundColor = .white
            lb.setTitle("Login", for: .normal)
            lb.setTitleColor(.black, for: .normal)
            return lb
        }()

        self.view.addSubview(self.loginButton)

        self.loginButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        self.loginButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }

}
