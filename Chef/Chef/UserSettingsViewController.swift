import UIKit
import SnapKit

class UserSettingsViewController: UIViewController, UserSettingsDelegate {

    let store = RecipeDataStore.shared
    var settingsView: UserSettingsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsView = UserSettingsView()
        self.settingsView.delegate = self

        self.view.addSubview(settingsView)
        settingsView.snapToSuperview()
        self.navigationItem.title = "User Settings"
    }


    func tapDiet() {
        print("Tap diet pressed")
        let dietVC = AddDietViewController()
        self.present(dietVC, animated: true, completion: nil)
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





