import UIKit

class ManualEntryViewController: UIViewController, ManualEntryViewDelegate{
    var manualEntryView: ManualEntryView!
    let store = RecipeDataStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        self.manualEntryView = ManualEntryView()
        self.manualEntryView.delegate = self
        self.view.addSubview(self.manualEntryView)
        self.manualEntryView.snapToSuperview()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func saveFoodButtonTapped() {
        print(#function)
        if let text = manualEntryView.foodEntryTextField.text {
        store.user.fridge.append(text)
        self.dismiss(animated: true, completion: nil)
        }
    }
    



}
