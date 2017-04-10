import UIKit
import SnapKit

class LoginViewController: UIViewController, LoginViewDelegate, UITextFieldDelegate {

    var loginView: LoginView!
    var userIsSigningUp: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginView = LoginView()
        self.loginView.delegate = self

        self.view.addSubview(self.loginView)
        self.loginView.snapToSuperview()
        self.createUI()

    }

    func signUp() {
        guard let email = self.loginView.usernameTextField.text, let password = self.loginView.passwordTextField.text else {
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
        guard let email = self.loginView.usernameTextField.text, let password = self.loginView.passwordTextField.text else {
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


    // MARK: - Actions

    func switchButtonTapped() {
        self.userIsSigningUp = self.userIsSigningUp ? false : true

        self.loginView.loginSignupButton.titleLabel?.alpha = 0.0
        self.loginView.switchButton.titleLabel?.alpha = 0.0

        if self.userIsSigningUp {
            self.loginView.loginSignupButton.setTitle("Sign Up", for: .normal)
            self.loginView.switchButton.setTitle("Login", for: .normal)
        } else {
            self.loginView.loginSignupButton.setTitle("Login", for: .normal)
            self.loginView.switchButton.setTitle("Sign Up", for: .normal)
        }

        UIView.animate(withDuration: 0.6) {
            self.loginView.loginSignupButton.titleLabel?.alpha = 1.0
            self.loginView.switchButton.titleLabel?.alpha = 1.0
        }
    }

    func shakeTextFields() {
        self.loginView.usernameTextField.shake()
        self.loginView.passwordTextField.shake()
    }


    // MARK: - Navigation

    func pushToTabBarController() {
        let tabBarController = TabBarController()
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }


    // MARK: - Login View Delegate

    func backgroundTapped() {
        self.loginView.usernameTextField.resignFirstResponder()
        self.loginView.passwordTextField.resignFirstResponder()
    }
    
}
