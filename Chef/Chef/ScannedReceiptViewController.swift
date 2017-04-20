import UIKit

class ScannedReceiptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    var receiptTableView: UITableView!
    var parsedIngredients: [String]!
    var backButton: UIBarButtonItem!
    let navBar = UINavigationBar()
    var autoCompleteTableView: UITableView!
    var autoCompleteData = [pastaAndNoodles, otherGrains, vegetables, fruits, meatsSeafoodsAndEggs, beansPeasAndTofu, nutsAndSeeds, dairy, beverages, alcoholicBeverages, condimentsAndSauce]
    var autoComplete = [String]()
    var currentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.createNavBar()
        self.navigationItem.title = "Scanned Receipt Content"
        autoCompleteTableView = UITableView()
    }

    // MARK: - Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == receiptTableView {
            if parsedIngredients != nil {
                return self.parsedIngredients.count
            } else {
                return 0
            }
        } else {
            return autoComplete.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == receiptTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "receiptDataCell", for: indexPath) as! ReceiptDataCell
            cell.ingredientTextField.text = parsedIngredients[indexPath.row]
            cell.ingredientTextField.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
            cell.textLabel?.text = autoComplete[indexPath.row] as String
            return cell
        }
    }

    //TODO: - Change the value of the receiptTableView textField
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == autoCompleteTableView {
            print("You selected an autocomplete row!")
            currentTextField.text = autoComplete[indexPath.row]
            autoCompleteTableView.isHidden = true
        }
    }

    //MARK: - TextField Configuration

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("shouldChangeCharactersInRange is called!!")
        autoCompleteTableView.isHidden = false
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        searchAutocompleteEntriesWith(substring)
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("We began editing a text field in receiptTV")
        currentTextField = textField
//        createAutoComplete()
    }

    func searchAutocompleteEntriesWith(_ substring: String) {
        print("Searchign autocmplete data")
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
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

    func createAutoComplete() {
        autoCompleteTableView.dataSource = self
        autoCompleteTableView.delegate = self
        autoCompleteTableView.isHidden = true

        autoCompleteTableView.snp.makeConstraints { (make) in
            make.width.height.equalTo(currentTextField.snp.width)
        }
        self.view.addSubview(autoCompleteTableView)
    }

    // MARK: - UI

    func createUI() {

        self.receiptTableView = {
            let tv = UITableView()
            tv.dataSource = self
            tv.delegate = self
            tv.register(ReceiptDataCell.self, forCellReuseIdentifier: "receiptDataCell")
            //            tv.layer.borderColor = Colors.flatironBlue.cgColor
            tv.backgroundColor = UIColor.white
            return tv
        }()
        self.view.addSubview(self.receiptTableView)
        createNavBar()
        receiptTableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
        }
        receiptTableView.translatesAutoresizingMaskIntoConstraints = false
        receiptTableView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
    }

    func createNavBar() {
        self.view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
        }
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.heightAnchor.constraint(equalToConstant: 70).isActive = true

        let backButton = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
    }

    // MARK: - Actions

    func back() {
        self.dismiss(animated: true, completion: nil)
    }
}
