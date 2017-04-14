import UIKit
import SnapKit

class AddDietViewController: UIViewController, AddDietDelegate {

    var dietaryRestrictions = [String]()
    var allergyList = [String]()
    var dietList = [String]()
    let store = RecipeDataStore.shared
    var addDietView: AddDietView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDietView = AddDietView()
        self.addDietView.delegate = self
        self.view.addSubview(addDietView)
        addDietView.snapToSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func dietButtonTapped(_ button: UIButton) {
        var btnTitle = button.title(for: .selected)
        _ = btnTitle?.characters.popLast()
        _ = btnTitle?.characters.popFirst()
        if button.isSelected {
            button.isSelected = false
            animate(button)
            if let indexToDelete = self.dietList.index(of: btnTitle!) {
                self.dietList.remove(at: indexToDelete)
            }
        } else {
            button.isSelected = true
            animate(button)
            self.dietList.append(btnTitle!)
        }
        print(self.dietList)
    }

    func allergyButtonTapped(_ button: UIButton) {
        var btnTitle = button.title(for: .selected)
        _ = btnTitle?.characters.popLast()
        _ = btnTitle?.characters.popFirst()
        if button.isSelected {
            button.isSelected = false
            animate(button)
            if let indexToDelete = self.allergyList.index(of: btnTitle!) {
                self.allergyList.remove(at: indexToDelete)
            }
        } else {
            button.isSelected = true
            animate(button)
            self.allergyList.append(btnTitle!)
        }
        print(self.allergyList)
    }

    func animate(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveLinear, animations: {
            button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (finished) in
            UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveLinear, animations: {
                button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
    }

    func saveButtonTapped() {
        var user = store.user
        user.dietList = self.dietList
        user.allergyList = self.allergyList
        self.dismiss(animated: true, completion: nil)
    }

}
