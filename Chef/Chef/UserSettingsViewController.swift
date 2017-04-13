import UIKit
import SnapKit

class UserSettingsViewController: UIViewController {

    let store = RecipeDataStore.shared
    var settingsView: UserSettingsView!

    var diet: UILabel!
    var logOut: UILabel!
    var resetData: UILabel!
    var deleteAcct: UILabel!
    var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.settingsView = UserSettingsView()

        stackView = UIStackView()
        self.view.addSubview(self.stackView)
        //TODO: - Make settings page prettier and separate into different class
        diet = UILabel()
        diet.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        diet.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        diet.text = "Set Dietary Restrictions"

        logOut = UILabel()
        logOut.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        logOut.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        logOut.text = "Log out"

        resetData = UILabel()
        resetData.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        resetData.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        resetData.text = "Reset Data"

        deleteAcct = UILabel()
        deleteAcct.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        deleteAcct.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        deleteAcct.text = "Delete account"


        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing = 16.0

        stackView.addArrangedSubview(diet)
        stackView.addArrangedSubview(logOut)
        stackView.addArrangedSubview(resetData)
        stackView.addArrangedSubview(deleteAcct)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints { (make) in

            //May be a better way the menu underneath the nav bar
            make.top.equalTo(self.view).offset(75.0)
            make.left.equalTo(self.view).offset(15.0)

        }

        self.view.backgroundColor = .white

        let dietGest = UITapGestureRecognizer(target: self, action: #selector(tapDiet))
        self.diet.isUserInteractionEnabled = true
        self.diet.addGestureRecognizer(dietGest)

        let logoutGest = UITapGestureRecognizer(target: self, action: #selector(tapLogOut))
        self.logOut.isUserInteractionEnabled = true
        self.logOut.addGestureRecognizer(logoutGest)

        let resetDataGest = UITapGestureRecognizer(target: self, action: #selector(tapResetData))
        self.resetData.isUserInteractionEnabled = true
        self.resetData.addGestureRecognizer(resetDataGest)

        let deleteAcctGest = UITapGestureRecognizer(target: self, action: #selector(tapDeleteAcct))
        self.deleteAcct.isUserInteractionEnabled = true
        self.deleteAcct.addGestureRecognizer(deleteAcctGest)

    }


    func tapDiet() {
        print("Tap diet pressed")
        let dietVC = AddDietViewController()
        self.present(dietVC, animated: true, completion: nil)
        //Diet possible choices -  pescetarian, lacto vegetarian, ovo vegetarian, vegan, and vegetarian
        //intolerances - dairy, egg, gluten, peanut, sesame, seafood, shellfish, soy, sulfite, tree nut, and wheat
    }

    func returnToLogin() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let _ = appDelegate.rootNavController.popToRootViewController(animated: true)
    }

    func tapLogOut() {
        print("Tap logout pressed")
        FirebaseManager.signOut()
        returnToLogin()
    }


    func tapResetData() {
        print("Tap reset data pressed")
        let alertController = UIAlertController(title: "Reset Data", message: "Please confirm that you wish to reset your data. You will not be able to retrive your data after confirming.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .destructive) { (action) in
            //Using addUser here since it provides the same result as resetting a user
            FirebaseManager.addUser(self.store.user)
            let confirmationController = UIAlertController(title: "Data Reset", message: "Your data has now been reset", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "Confirm", style: .default, handler: nil)
            confirmationController.addAction(confirm)
            self.present(confirmationController, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirm)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }

    func tapDeleteAcct() {
        print("Tap delete account pressed")
        let alertController = UIAlertController(title: "Delete Account", message: "Please confirm that you wish to delete your account. You will not be able to retrive your account after confirming.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .destructive) { (action) in
            FirebaseManager.deleteUser()
            FirebaseManager.deleteUserData(self.store.user)
            let confirmationController = UIAlertController(title: "Account Deleted", message: "Your account has been deleted", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "Conirm", style: .default, handler: { _ in
                self.returnToLogin()
            })
            confirmationController.addAction(confirm)
            self.present(confirmationController, animated: true, completion: nil)

        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirm)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }

}





