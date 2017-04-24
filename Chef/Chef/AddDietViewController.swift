import UIKit
import SnapKit

class AddDietViewController: UIViewController, AddDietDelegate {

    var dietList = [String]()
    var allergyList = [String]()
    var store = RecipeDataStore.shared
    var addDietView: AddDietView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDietView = AddDietView()
        self.addDietView.delegate = self
        self.view.addSubview(addDietView)
        addDietView.snapToSuperview()
        selectButtons()
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
        if !self.dietList.isEmpty{
            store.updateDiet(with: self.dietList)
        }
        if !self.allergyList.isEmpty{
            store.updateAllergy(with: self.allergyList)
        }
        self.dismiss(animated: true, completion: nil)
    }

    func selectButtons() {
        let allFoodButtons = [addDietView.pescetarian, addDietView.veg, addDietView.vegan, addDietView.paleo, addDietView.dairy, addDietView.egg, addDietView.gluten, addDietView.peanut, addDietView.sesame, addDietView.seafood, addDietView.shellfish, addDietView.soy, addDietView.sulfite, addDietView.treeNut, addDietView.wheat]

        for button in allFoodButtons {
            var btnSelected = false
            var btnTitle = button?.title(for: .selected)
            _ = btnTitle?.characters.popLast()
            _ = btnTitle?.characters.popFirst()
            if let btnTitle = btnTitle {
                if store.user.allergyList.contains(btnTitle) || store.user.dietList.contains(btnTitle) {
                    btnSelected = true
                } else {
                    btnSelected = false
                }
            } else {
                btnSelected = false
            }
            if btnSelected {
                button?.isSelected = true
            }
        }
    }

}
