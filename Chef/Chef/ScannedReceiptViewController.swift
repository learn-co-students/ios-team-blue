import UIKit

class ScannedReceiptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var tableView: UITableView!
//    var urlToLastPhoto: String! = {
//
//        return "\(DropDownViewController.getDocumentsDirectory())"
//    }()

    let test = DropDownViewController.getDocumentsDirectory()
    var dropDownViewController: DropDownViewController!
    var parsedIngredients = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()

//        setParsedIngredients()
//        testParsedIngredients()
        print("THE URL IS: \(test)")

        self.navigationItem.title = "Scanned Receipt Contents"
    }




//
//     func setParsedIngredients() {
//
//        GoogleVisionAPIClient.getDescriptionfor(dropDownViewController.imageData) { (ingredientsList) in
//            DispatchQueue.main.async {
//                print("HERE WE ARE!!!", #function)
//                self.parsedIngredients = ingredientsList
//                print(ingredientsList)
//                self.tableView.reloadData()
//            }
//        }
//    }

//        GoogleVisionAPIClient.getDescriptionfor(urlToLastPhoto, completion: { (ingredientsList) in
//            DispatchQueue.main.async {
//                print("HERE WE ARE!!!", #function)
//                self.parsedIngredients = ingredientsList
//                print(ingredientsList)
//                self.tableView.reloadData()
//            }
//        })
//    }

    // MARK: - Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("The INGREDIENTS ARE \(parsedIngredients)")
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
