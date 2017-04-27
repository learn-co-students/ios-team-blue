import UIKit

class ScannedReceiptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    //need to edit the cell text in the datasource in order to fix swipe to delete bug.

    var store = RecipeDataStore.shared
    var receiptTableView: UITableView!
    var parsedIngredients = [String]()
    var editedIngredients = [String]()
    var editedText = ""
    var saveButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        editedIngredients = parsedIngredients
        self.createUI()
        self.navigationItem.title = "Receipt Content"
        saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveItems))
        navigationItem.rightBarButtonItem = saveButton
    }

    // MARK: - Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return self.editedIngredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "receiptDataCell", for: indexPath) as! ReceiptDataCell
            cell.ingredientTextField.text = editedIngredients[indexPath.row]
            cell.ingredientTextField.delegate = self
            return cell
    }

    // MARK: - Delegate

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let selectedIngredient = editedIngredients[indexPath.row]
            editedIngredients = editedIngredients.filter {$0 != selectedIngredient}
            self.receiptTableView.reloadData()
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text {
            self.editedText = text
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index = editedIngredients.index(of: editedText)
        if let index = index {
            editedIngredients.remove(at: index)
            if let text = textField.text {
                editedIngredients.insert(text, at: index)
            }
        }
    }

    //MARK: - TextField Configuration

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: - UI

    func createUI() {

        self.receiptTableView = {
            let tv = UITableView()
            tv.dataSource = self
            tv.delegate = self
            tv.register(ReceiptDataCell.self, forCellReuseIdentifier: "receiptDataCell")
            return tv
        }()
        self.view.addSubview(self.receiptTableView)
        receiptTableView.snapToSuperview()
        receiptTableView.backgroundColor = .white
    }

    // MARK: - Actions

    func saveItems() {
        print(editedIngredients)
        let newIngredients = editedIngredients.filter { $0 != "" }
        store.updateFridge(with: newIngredients)
        self.navigationController?.popToRootViewController(animated: true)
    }

}
