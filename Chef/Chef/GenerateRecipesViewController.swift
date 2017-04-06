import UIKit

class GenerateRecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }


    // MARK: - Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }


    // MARK: - Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }


    // MARK: - UI

    func createUI() {
        self.createTableView()
    }

    func createTableView() {
        self.tableView = UITableView(frame: self.view.frame)

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "recipeCell")

        self.view.addSubview(self.tableView)
    }

}
