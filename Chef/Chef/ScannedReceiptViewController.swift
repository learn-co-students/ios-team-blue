import UIKit

class ScannedReceiptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    var parsedIngredients: [String]!
    var backButton: UIBarButtonItem!
    let navBar = UINavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.navigationItem.title = "Scanned Receipt Content"


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
            let tv = UITableView()
            tv.dataSource = self
            tv.delegate = self
            tv.register(ReceiptDataCell.self, forCellReuseIdentifier: "receiptDataCell")
            tv.layer.borderColor = Style.flatironBlue.cgColor
            tv.backgroundColor = UIColor.white
            return tv
        }()

        self.view.addSubview(self.tableView)
        createNavBar()
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true


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

//}

}
