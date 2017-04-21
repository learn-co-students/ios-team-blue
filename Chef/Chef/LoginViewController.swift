import UIKit
import SnapKit

class LoginViewController: UIViewController, LoginViewDelegate, UITextFieldDelegate {

    let store = RecipeDataStore.shared
    var loginView: LoginView!
    var userIsSigningUp: Bool = false


    // MARK: View Controller Life-Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginView = LoginView()
        self.loginView.delegate = self

        self.view.addSubview(self.loginView)
        self.loginView.snapToSuperview()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if self.loginView.isLoading {
            self.loginView.animateLoading(false)
            self.loginView.usernameTextField.text = ""
            self.loginView.passwordTextField.text = ""
        }
    }


    // MARK: Login/Signup

    /// If user already exists, just log in
    func signUp() {
        print("\nLoginViewController.\(#function) -- Attempting signup")

        // show loading view
        self.loginView.animateLoading(true)

        // guard against nil text fields
        guard let email = self.loginView.usernameTextField.text, let password = self.loginView.passwordTextField.text else {
            print("LoginViewController.\(#function) -- Error: Nil text field")
            self.animateUIOnAuthFail()
            return
        }

        // create and validate new user and attempt login
        let newUser = User(email: email)
        FirebaseManager.checkIfUserExists(newUser) { userAlreadyExists in
            if userAlreadyExists {
                FirebaseManager.login(email: email, password: password) { success in
                    self.handleLogin(success, newUser: newUser)
                }
            } else {
                FirebaseManager.signUp(email: email, password: password) { success in
                    if success {
                        FirebaseManager.login(email: email, password: password) { success in
                            //self.handleLogin(success, newUser: newUser)
                            if success {
                                self.store.setUser(newUser) {
                                    //self.pushToTabBarController()
                                    let tabBarController = TabBarController()
                                    tabBarController.generateRecipesVC.isFirstTimeLoggingIn = true
                                    self.navigationController?.pushViewController(tabBarController, animated: true)
                                }
                            } else {
                                print("LoginViewController.\(#function) -- login failed")
                                self.animateUIOnAuthFail()
                            }
                        }
                    } else {
                        print("LoginViewController.\(#function) -- signup failed")
                        self.animateUIOnAuthFail()
                    }
                }
            }
        }
    }

    func logIn() {
        print("\nLoginViewController.\(#function) -- Attempting login")

        // show loading view
        self.loginView.animateLoading(true)

        // guard against nil text fields
        guard let email = self.loginView.usernameTextField.text, let password = self.loginView.passwordTextField.text else {
            print("LoginViewController.\(#function) -- Error: Nil text field")
            self.animateUIOnAuthFail()
            return
        }

        // create user object and validate it
        // attempt login
        let newUser = User(email: email)
        FirebaseManager.checkIfUserExists(newUser) { userAlreadyExists in
            if userAlreadyExists {
                FirebaseManager.login(email: email, password: password) { success in
                    self.handleLogin(success, newUser: newUser)
                }
            } else {
                print("LoginViewController.\(#function) -- User \(email) does not exist")
                self.animateUIOnAuthFail()
            }
        }
    }


    // MARK: - Helper

    private func animateUIOnAuthFail() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loginView.animateLoading(false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.loginView.shakeTextFields()
            }
        }
    }

    /// Set user and push to the next view controller
    private func handleLogin(_ loginIsSuccessful: Bool, newUser: User) {
        if loginIsSuccessful {
            self.store.setUser(newUser) {
                self.pushToTabBarController()
            }
        } else {
            print("LoginViewController.\(#function) -- login failed")
            self.animateUIOnAuthFail()
        }
    }

    private func pushToTabBarController() {
        let tabBarController = TabBarController()
        self.navigationController?.pushViewController(tabBarController, animated: true)
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

}
