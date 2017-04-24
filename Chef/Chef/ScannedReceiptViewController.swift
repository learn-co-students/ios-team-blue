import UIKit

class ScannedReceiptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

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
                return self.parsedIngredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "receiptDataCell", for: indexPath) as! ReceiptDataCell
            cell.ingredientTextField.text = parsedIngredients[indexPath.row]
            cell.ingredientTextField.delegate = self
            return cell
    }

    // MARK: - Delegate

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let selectedIngredient = parsedIngredients[indexPath.row]
            parsedIngredients = parsedIngredients.filter {$0 != selectedIngredient}
            print("Filetered parsedIngredients are", parsedIngredients)
            editedIngredients = parsedIngredients
            self.receiptTableView.reloadData()
        }
    }

    //after getting the data from the edited cell, remove the original value from the array and push the new value into the array
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text {
            self.editedText = text
            print("begin editing", text)

        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index = editedIngredients.index(of: editedText)
        if let index = index {
            editedIngredients.remove(at: index)
        }
        if let text = textField.text {
            editedIngredients.append(text)
            print("end editing", text)
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
//        let newIngredients = editedIngredients.filter { $0 != "" }
//        store.updateFridge(with: newIngredients)
        self.navigationController?.popToRootViewController(animated: true)
    }

}
