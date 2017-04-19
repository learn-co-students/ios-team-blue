import UIKit

class ScannedReceiptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var tableView: UITableView!
    var urlToLastPhoto: String! = {
        return "\(DropDownViewController.getDocumentsDirectory())"
    }()
    var parsedIngredients = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        setParsedIngredients()

        self.navigationItem.title = "Scanned Receipt Contents"
        self.createUI()
    }

    func setParsedIngredients() {
        GoogleVisionAPIClient.getDescriptionfor(urlToLastPhoto, completion: { (ingredientsList) in
            DispatchQueue.main.async {
                self.parsedIngredients = ingredientsList
                print(ingredientsList)
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsedIngredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptDataCell", for: indexPath) as! ReceiptDataCell
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
            tv.layer.borderColor = Style.flatironBlue.cgColor
            return tv
        }()

        self.view.addSubview(self.tableView)
    }




    
}
