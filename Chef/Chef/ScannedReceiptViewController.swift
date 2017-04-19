import UIKit

class ScannedReceiptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    var parsedIngredients: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
        self.navigationItem.title = "Scanned Receipt Contents"
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
        return cell
    }

    // MARK: - Delegate



    // MARK: - UI

    func createUI() {

        self.tableView = {
            let tv = UITableView(frame: self.view.frame)
            tv.dataSource = self
            tv.delegate = self
            tv.register(ReceiptDataCell.self, forCellReuseIdentifier: "receiptDataCell")
            tv.layer.borderColor = Style.flatironBlue.cgColor
            return tv
        }()

        self.view.addSubview(self.tableView)
    }

}
