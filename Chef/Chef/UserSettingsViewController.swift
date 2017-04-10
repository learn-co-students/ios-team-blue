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
        diet.backgroundColor = UIColor.yellow
        diet.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        diet.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        diet.text  = "Set Dietary Restrictions"

        logOut = UILabel()
        logOut.backgroundColor = UIColor.yellow
        logOut.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        logOut.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        logOut.text  = "Log out"

        resetData = UILabel()
        resetData.backgroundColor = UIColor.yellow
        resetData.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        resetData.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        resetData.text  = "Reset Data"

        deleteAcct = UILabel()
        deleteAcct.backgroundColor = UIColor.yellow
        deleteAcct.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        deleteAcct.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        deleteAcct.text  = "Delete account"


        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing = 16.0

        stackView.addArrangedSubview(diet)
        stackView.addArrangedSubview(logOut)
        stackView.addArrangedSubview(resetData)
        stackView.addArrangedSubview(deleteAcct)

        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(100)
            make.left.equalTo(self.view)
        }


        self.view.backgroundColor = .white
        
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




