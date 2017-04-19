import UIKit
import Foundation
import SnapKit

class FridgeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let store = RecipeDataStore.shared
    var tableView: UITableView!
    var addButton: UIBarButtonItem!
    var addButtonTapped = false
    var dropDownViewController: DropDownViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Fridge"
        self.createUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }


    // MARK: - Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.user.fridge.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fridgeCell", for: indexPath) as! FridgeCell
        cell.textLabel?.text = self.store.user.fridge[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            let selectedIngredient = store.user.fridge[indexPath.row]
            store.user.fridge = store.user.fridge.filter {$0 != selectedIngredient}
            self.tableView.reloadData()
        }
    }


    // MARK: - Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    // MARK: - UI

    func createUI() {
        self.createTableView()
        self.createAddButton()
        self.createDropDownViewController()
    }

    func createTableView() {
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(FridgeCell.self, forCellReuseIdentifier: "fridgeCell")
        self.view.addSubview(self.tableView)
    }

    func createAddButton() {
        self.addButton = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addIngredient))
        self.navigationItem.rightBarButtonItem = addButton
        addButton.tintColor = Style.flatironBlue
    }

    func createDropDownViewController() {
        self.dropDownViewController = DropDownViewController()
        self.addChildViewController(dropDownViewController)
        self.dropDownViewController.didMove(toParentViewController: self)

        self.view.addSubview(dropDownViewController.view)
        self.dropDownViewController.view.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
    }


    // MARK: - Actions

    func addIngredient() {
        print(#function)
        addButtonTapped = !addButtonTapped
        self.dropDownViewController.dropDownView.alpha = addButtonTapped ? 1.0 : 0.0
    }

    func createIngredients() {
        var ingredients = [Ingredient]()
        for item in store.user.fridge {

        }
    }

    func sortByCategory(_ item) {



    }

}

//var foodGroups = [grains, vegetable, fruit, proteins, dairies, other]
