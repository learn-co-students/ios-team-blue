import Foundation
import UIKit
import SnapKit

class UserSettingsView: UIView {

    var heading: UILabel!
    var diet: UILabel!
    var logOut: UILabel!
    var resetData: UILabel!
    var deleteAcct: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    
    func commonInit() {
        createHeading()
        createDiet()
        createLogOut()
        createResetData()
        createDltAcct()
    }

    func createHeading() {
        heading = UILabel()
        self.addSubview(heading)
        heading.text = "User Settings"
        heading.textColor = .white
        heading.font = UIFont(name: Style.regular, size: 48)
        heading.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
    }

    func createDiet() {
        diet = UILabel()
        self.addSubview(diet)
        diet.font = UIFont(name: Style.regular, size: 20)
        diet.textColor = .white
        diet.text = "Set Dietary Restrictions"
        let dietGest = UITapGestureRecognizer(target: self, action: #selector(tapDiet))
        self.diet.isUserInteractionEnabled = true
        self.diet.addGestureRecognizer(dietGest)
        diet.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(heading.snp.bottom).offset(5)
        }
    }

    func createLogOut() {
        logOut = UILabel()
        self.addSubview(logOut)
        logOut.text = "Log out"
        logOut.font = UIFont(name: Style.regular, size: 20)
        logOut.textColor = .white
        logOut.snp.makeConstraints { (make) in
            make.top.equalTo(diet.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        }
        let logoutGest = UITapGestureRecognizer(target: self, action: #selector(tapLogOut))
        self.logOut.isUserInteractionEnabled = true
        self.logOut.addGestureRecognizer(logoutGest)
    }

    func createResetData() {
        resetData = UILabel()
        self.addSubview(resetData)
        resetData.font = UIFont(name: Style.regular, size: 20)
        resetData.textColor = .red
        resetData.text = "Reset Data"
        resetData.snp.makeConstraints { (make) in
            make.top.equalTo(logOut.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        }

        let resetDataGest = UITapGestureRecognizer(target: self, action: #selector(tapResetData))
        self.resetData.isUserInteractionEnabled = true
        self.resetData.addGestureRecognizer(resetDataGest)
    }

    func createDltAcct() {
        deleteAcct = UILabel()
        self.addSubview(deleteAcct)
        deleteAcct.font = UIFont(name: Style.regular, size: 20)
        deleteAcct.textColor = .red
        deleteAcct.text = "Delete account"
        deleteAcct.snp.makeConstraints { (make) in
            make.top.equalTo(resetData.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        }
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
