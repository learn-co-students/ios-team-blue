import UIKit
import Foundation
import SnapKit

class FridgeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let store = RecipeDataStore.shared
    var tableView: UITableView!
    var addButton: UIButton!
    var addBarButton: UIBarButtonItem!
    var addButtonSelected = false
    var dropDownViewController: DropDownViewController!
    var groupedItems = [String: [String]]()
    var groupedFoods = [FoodGroups]()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Fridge"
        self.createUI()
        self.tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.groupedItems = self.sortByCategory()
        createFoodGroups()
        self.tableView.reloadData()
    }

    // MARK: - Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedFoods.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedFoods[section].groupItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fridgeCell", for: indexPath) as! FridgeCell
        cell.textLabel?.text = groupedFoods[indexPath.section].groupItems[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedFoods[section].groupName
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let selectedIngredient = store.user.fridge[indexPath.row]
            store.user.fridge = store.user.fridge.filter {$0 != selectedIngredient}
            self.tableView.reloadData()
        }
    }

    // MARK: - Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }

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
        addButton = UIButton(type: .custom)
        addButton.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        addButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        addButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        addButton.tintColor = Colors.flatironBlue
        addBarButton = UIBarButtonItem(customView: addButton)
        self.navigationItem.rightBarButtonItem = addBarButton
        addButton.tintColor = Colors.flatironBlue
//        navigationController?.navigationBar.barTintColor = UIColor.white

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
        addButtonSelected = !addButtonSelected
//        addBarButton.customView!.transform = CGAffineTransform(scaleX: 0, y: 0)
//        if addButtonSelected {
//            UIView.animate(withDuration: 0.5, animations:{
//                self.addBarButton.customView!.transform = CGAffineTransform(rotationAngle: .pi / 4)
//            })
//        } else {
//            UIView.animate(withDuration: 0.5, animations:{
//                self.addBarButton.customView!.transform = CGAffineTransform(rotationAngle: .pi)
//            })
//        }
        toggleMenu()
    }

    func toggleMenu() {
        if addButtonSelected {
            UIView.animate(withDuration: 0.5, animations: {
                self.dropDownViewController.dropDownView.center.y += 160
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.dropDownViewController.dropDownView.center.y -= 160
            })
        }

    }

    //MARK: - Food Sorting

    func sortByCategory() -> [String: [String]] {
        var groupedByType = [String: [String]]()
        let items = store.user.fridge
        for item in items {
            if isGrain(item) {
                if groupedByType.keys.contains("Grains") {
                    groupedByType["Grains"]?.append(item)
                } else {
                    groupedByType.updateValue([item], forKey: "Grains")
                }
            } else if isVeggie(item) {
                if groupedByType.keys.contains("Vegetables") {
                    groupedByType["Vegetables"]?.append(item)
                } else {
                    groupedByType.updateValue([item], forKey: "Vegetables")
                }
            } else if isFruit(item) {
                if groupedByType.keys.contains("Fruits") {
                    groupedByType["Fruits"]?.append(item)
                } else {
                    groupedByType.updateValue([item], forKey: "Fruits")
                }
            } else if isProtein(item) {
                if groupedByType.keys.contains("Proteins") {
                    groupedByType["Proteins"]?.append(item)
                } else {
                    groupedByType.updateValue([item], forKey: "Proteins")
                }
            } else if isDairy(item) {
                if groupedByType.keys.contains("Dairy") {
                    groupedByType["Dairy"]?.append(item)
                } else {
                    groupedByType.updateValue([item], forKey: "Dairy")
                }
            } else {
                if groupedByType.keys.contains("Other") {
                    groupedByType["Other"]?.append(item)
                } else {
                    groupedByType.updateValue([item], forKey: "Other")
                }
            }
        }
        return groupedByType
    }

    func isGrain(_ food: String) -> Bool {
        if pastaAndNoodles.contains(food) ||
            otherGrains.contains(food) {
            return true
        } else {
            return false
        }
    }
    func isVeggie(_ food: String) -> Bool {
        if vegetables.contains(food) {
            return true
        } else {
            return false
        }
    }
    func isFruit(_ food: String) -> Bool {
        if fruits.contains(food) {
            return true
        } else {
            return false
        }
    }
    func isProtein(_ food: String) -> Bool {
        if meatsSeafoodsAndEggs.contains(food) ||
            beansPeasAndTofu.contains(food) ||
            nutsAndSeeds.contains(food) {
            return true
        } else {
            return false
        }
    }
    func isDairy(_ food: String) -> Bool {
        if dairy.contains(food) {
            return true
        } else {
            return false
        }
    }
    func isOther(_ food: String) -> Bool {
        if beverages.contains(food) ||
            alcoholicBeverages.contains(food) ||
            condimentsAndSauce.contains(food) {
            return true
        } else {
            return false
        }
    }

    func createFoodGroups() {
        groupedFoods.removeAll()
        for (key, value) in groupedItems {
            groupedFoods.append(FoodGroups(groupName: key, groupItems: value))
        }
    }

}











