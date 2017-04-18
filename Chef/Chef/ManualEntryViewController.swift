import UIKit
import SnapKit

class ManualEntryViewController: UIViewController, ManualEntryViewDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    var manualEntryView: ManualEntryView!
    let store = RecipeDataStore.shared
    var tableView: UITableView!
    var autoCompleteData = [pastaAndNoodles, otherGrains, vegetables, fruits,  meatsSeafoodsAndEggs, beansPeasAndTofu,nutsAndSeeds, dairy, beverages, alcoholicBeverages, condimentsAndSauce]
    var autoComplete: [String] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        self.manualEntryView = ManualEntryView()
        self.manualEntryView.delegate = self
        self.view.addSubview(self.manualEntryView)
        self.manualEntryView.snapToSuperview()
        self.tableView = manualEntryView.tableView
        tableView.dataSource = self
        tableView.delegate = self


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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
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
        tableView.reloadData()
    }
    
}






