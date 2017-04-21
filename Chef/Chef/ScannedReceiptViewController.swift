import UIKit

class ScannedReceiptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    var receiptTableView: UITableView!
    var parsedIngredients: [String]!
    var addButton: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.navigationItem.title = "Receipt Content"
    }

    // MARK: - Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if parsedIngredients != nil {
                return self.parsedIngredients.count
            } else {
                return 0
            }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "receiptDataCell", for: indexPath) as! ReceiptDataCell
            cell.ingredientTextField.text = parsedIngredients[indexPath.row]
            cell.ingredientTextField.delegate = self
            return cell
    }

    //MARK: - TextField Configuration


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.clearButtonMode = .whileEditing
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
        receiptTableView.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Actions

    func back() {
        self.dismiss(animated: true, completion: nil)
    }
}
