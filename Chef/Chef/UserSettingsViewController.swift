import UIKit
import SnapKit

class UserSettingsViewController: UIViewController {

    var diet: UILabel!
    var logOut: UILabel!
    var resetData: UILabel!
    var deleteAcct: UILabel!
    var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        stackView = UIStackView()
        self.view.addSubview(self.stackView)

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
        //TODO: - Add VC to set Dietary Restrictions
    }

    func tapLogOut() {
        print("Tap logout pressed")
        //TODO: - Log out in Firebase
    }

    func tapResetData() {
        print("Tap reset data pressed")
        let alertController = UIAlertController(title: "Reset Data", message: "Please confirm that you wish to reset your data. You will not be able to retrive your data after confirming.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .destructive) { (action) in
            //TODO: - Delete data in Firebase
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirm)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }

    func tapDeleteAcct() {
        print("Tap delete account pressed")
        let alertController = UIAlertController(title: "Delete Account", message: "Please confirm that you wish to delete your account. You will not be able to retrive your account information after confirming.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .destructive) { (action) in
            //TODO: - Delete account in Firebase
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirm)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}





