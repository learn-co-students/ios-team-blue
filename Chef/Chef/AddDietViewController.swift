import UIKit
import SnapKit

class AddDietViewController: UIViewController, AddDietDelegate {

    var dietList = [String]()
    var allergyList = [String]()
    let store = RecipeDataStore.shared
    var addDietView: AddDietView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDietView = AddDietView()
        self.addDietView.delegate = self
        self.view.addSubview(addDietView)
        addDietView.snapToSuperview()
        selectButtons()
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
        if !dietList.isEmpty{
            FirebaseManager.addDiet(dietList, to: store.user)
        }
        user.allergyList = self.allergyList
        if !allergyList.isEmpty{
            FirebaseManager.addAllergy(allergyList, to: store.user)
        }
        self.dismiss(animated: true, completion: nil)
    }

    
    func saveBtnSelection(_ button: UIButton, btnTitle: String?) {
        let defaults = UserDefaults.standard
        if button.isSelected{
            if let btnTitle = btnTitle {
                defaults.set(true, forKey: btnTitle)
            }
        } else {
            if let btnTitle = btnTitle {
                defaults.set(false, forKey: btnTitle)
            }
        }

    }

    func selectButtons() {
        let allFoodButtons = [addDietView.pescetarian, addDietView.veg, addDietView.vegan, addDietView.paleo, addDietView.dairy, addDietView.egg, addDietView.gluten, addDietView.peanut, addDietView.sesame, addDietView.seafood, addDietView.shellfish, addDietView.soy, addDietView.sulfite, addDietView.treeNut, addDietView.wheat]
        let defaults = UserDefaults.standard

        for button in allFoodButtons {
            var btnSelected = false
            var btnTitle = button?.title(for: .selected)
            _ = btnTitle?.characters.popLast()
            _ = btnTitle?.characters.popFirst()
            if let btnTitle = btnTitle {
                btnSelected = defaults.bool(forKey: btnTitle)
            } else {
                btnSelected = false
            }

            if btnSelected {
                button?.isSelected = true
            }
        }
    }

}
