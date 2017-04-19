import UIKit

class UserSettingsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let store = RecipeDataStore.shared
    var collectionView: UICollectionView!
    private let settings = ["Set Dietary Restrictions", "Log Out", "Reset Data", "Delete Account"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
        self.navigationItem.title = "User Settings"

        

    }


    // MARK: - Data Source

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsCell", for: indexPath) as! SettingsCell

        cell.label.text = self.settings[indexPath.row]

        switch indexPath.row {
        case 2, 3:
            cell.label.textColor = .red
        default:
            cell.label.textColor = Colors.flatironBlue
        }

        return cell
    }


    // MARK: - Delegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.tapDiet()
        case 1:
            self.tapLogOut()
        case 2:
            self.tapResetData()
        case 3:
            self.tapDeleteAcct()
        default:
            break
        }
    }


    // MARK: - Actions

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
        FirebaseManager.signOut { success in
            if success {
                returnToLogin()
            }
        }
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
            FirebaseManager.deleteUser { success in
                if success {
                    FirebaseManager.deleteUserData(self.store.user)
                    let confirmationController = UIAlertController(title: "Account Deleted", message: "Your account has been deleted", preferredStyle: .alert)
                    let confirm = UIAlertAction(title: "Confirm", style: .default, handler: { _ in
                        self.returnToLogin()
                    })
                    confirmationController.addAction(confirm)
                    self.present(confirmationController, animated: true, completion: nil)
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirm)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }


    // MARK: - UI

    func createUI() {
        let spacing = CGFloat(8)
        let cellWidth = self.view.bounds.width - CGFloat(2 * spacing)
        let cellHeight = CGFloat(55)
        let cellSize = CGSize(width: cellWidth, height: cellHeight)

        let layout: UICollectionViewFlowLayout = {
            let cvfl = UICollectionViewFlowLayout()
            cvfl.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            cvfl.itemSize = cellSize
            cvfl.minimumLineSpacing = spacing
            return cvfl
        }()

        self.collectionView = {
            let cv = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            cv.dataSource = self
            cv.delegate = self
            cv.register(SettingsCell.self, forCellWithReuseIdentifier: "settingsCell")
            cv.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            return cv
        }()
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snapToSuperview()
    }
    
}
