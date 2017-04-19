import UIKit
import SnapKit

class ManualEntryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, ManualEntryViewDelegate {

    var manualEntryView: ManualEntryView!
    var saveFoodButton: UIButton!
    let store = RecipeDataStore.shared
    var autoCompleteTableView: UITableView!
    var autoCompleteData = [pastaAndNoodles, otherGrains, vegetables, fruits,  meatsSeafoodsAndEggs, beansPeasAndTofu,nutsAndSeeds, dairy, beverages, alcoholicBeverages, condimentsAndSauce]
    var autoComplete = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.manualEntryView = ManualEntryView()
        self.manualEntryView.delegate = self
        self.view.addSubview(self.manualEntryView)
        self.manualEntryView.snapToSuperview()
        self.autoCompleteTableView = manualEntryView.autoCompleteTableView
        autoCompleteTableView.dataSource = self
        autoCompleteTableView.delegate = self
        self.manualEntryView.foodEntryTextField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func saveFoodButtonTapped() {
        if let text = manualEntryView.foodEntryTextField.text {
            store.user.fridge.append(text)
            self.dismiss(animated: true, completion: nil)
        }
    }
//MARK: - TableView and TextFieldDelegate Configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = autoComplete[indexPath.row] as String
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        manualEntryView.foodEntryTextField.text = autoComplete[indexPath.row]
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        autoCompleteTableView.isHidden = false
        let substring = (manualEntryView.foodEntryTextField.text! as NSString).replacingCharacters(in: range, with: string)
        searchAutocompleteEntriesWith(substring)
        return true
    }

    func searchAutocompleteEntriesWith(_ substring: String) {
        autoComplete.removeAll(keepingCapacity: false)
        for foodArray in autoCompleteData {
            for item in foodArray {
                let myString: NSString! = item as NSString
                let substringRange: NSRange! = myString.range(of: substring)
                if substringRange.location == 0 {
                    autoComplete.append(item)
                }
            }
        }
        autoCompleteTableView.reloadData()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
