import UIKit
import SnapKit

class LoginViewController: UIViewController, LoginViewDelegate, UITextFieldDelegate {

    let store = RecipeDataStore.shared
    var loginView: LoginView!
    var userIsSigningUp: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginView = LoginView()
        self.loginView.delegate = self

        self.view.addSubview(self.loginView)
        self.loginView.snapToSuperview()
    }

    override func viewDidDisappear(_ animated: Bool) {
        if self.loginView.isLoading {
            self.loginView.toggleLoading()
            self.loginView.usernameTextField.text = ""
            self.loginView.passwordTextField.text = ""
        }
    }

    func signUp() {
        self.loginView.toggleLoading()

        guard let email = self.loginView.usernameTextField.text, let password = self.loginView.passwordTextField.text else {
            return
        }
        FirebaseManager.signUp(email: email, password: password) { success in
            if success {
                self.logIn()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.loginView.toggleLoading()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        self.loginView.shakeTextFields()
                    }
                }
            }
        }
    }
    
    func logIn() {
        if !self.loginView.isLoading {
            self.loginView.toggleLoading()
        }

        guard let email = self.loginView.usernameTextField.text, let password = self.loginView.passwordTextField.text else {
            return
        }
        FirebaseManager.login(email: email, password: password) { success in
            if success {
                let user = User(email: email)
                self.store.setUser(user)

                FirebaseManager.checkIfUserExists(user) { userExists in
                    if userExists {
                        self.store.pullDataForUser(user) {
                            self.pushToTabBarController()
                        }
                    } else {
                        FirebaseManager.addUser(user)
                        self.pushToTabBarController()
                    }
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.loginView.toggleLoading()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        self.loginView.shakeTextFields()
                    }
                }
            }
        }
    }


    // MARK: - Login View Delegate

    func backgroundTapped() {
        self.loginView.hideKeyboard()
    }

    func backgroundDoubleTapped() {
        self.loginView.usernameTextField.text = "blue@flatiron.com"
        self.loginView.passwordTextField.text = "password"
        self.logIn()
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


    // MARK: - Navigation

    func pushToTabBarController() {
        let tabBarController = TabBarController()
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }

}
