import UIKit
import SnapKit

class FridgeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let store = RecipeDataStore.shared
    var tableView: UITableView!
    var addBarButtonItem: UIBarButtonItem!
    var addButtonSelected = false
    var dropDownViewController: DropDownViewController!
    var groupedItems = [String: [String]]()
    var foodCollection = [FoodGroups]()


    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Fridge"
        self.createUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.groupedItems = self.sortByCategory(nil)
        createFoodGroups()
        self.tableView.reloadData()
        addButtonSelected = false
    }

    // MARK: - Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        return foodCollection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodCollection[section].groupItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fridgeCell", for: indexPath)
        cell.textLabel?.text = foodCollection[indexPath.section].groupItems[indexPath.row]
        cell.textLabel?.font = Fonts.medium16
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let itemDelete = foodCollection[indexPath.section].groupItems[indexPath.row]
            store.deleteIngredient(itemDelete) {
                tableView.reloadData()
            }
            foodCollection[indexPath.section].groupItems.remove(at: indexPath.row)
            if foodCollection[indexPath.section].groupItems.isEmpty {
                foodCollection.remove(at: indexPath.section)
            }
            tableView.reloadData()
        }
    }


    // MARK: - Delegate

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(FridgeSectionHeaderView.height)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = FridgeSectionHeaderView()
        headerView.label.text = self.foodCollection[section].groupName
        return headerView
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    // MARK: - UI

    func createUI() {
        self.tableView = {
            let tv = UITableView(frame: self.view.frame)
            tv.dataSource = self
            tv.delegate = self
            tv.register(FridgeCell.self, forCellReuseIdentifier: "fridgeCell")
            tv.separatorInset = UIEdgeInsets.zero
            tv.allowsSelection = false
            return tv
        }()
        self.view.addSubview(self.tableView)

        self.addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addIngredient))
        self.addBarButtonItem.tintColor = Colors.flatironBlue
        self.navigationItem.rightBarButtonItem = self.addBarButtonItem

        self.dropDownViewController = DropDownViewController()
        self.addChildViewController(dropDownViewController)
        self.dropDownViewController.didMove(toParentViewController: self)

        self.view.addSubview(dropDownViewController.view)
        self.dropDownViewController.view.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-4)
            make.top.equalToSuperview().offset(-40)
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalTo(40)
        }
    }


    // MARK: - Actions

    func addIngredient() {
        self.addButtonSelected = !self.addButtonSelected
        self.toggleMenu()
    }

    func toggleMenu() {
        if addButtonSelected {
            UIView.animate(withDuration: 0.2, animations: {
                self.dropDownViewController.view.center.y += 110
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.dropDownViewController.view.center.y -= 110
            })
        }
    }


    // MARK: - Food Sorting

    func sortByCategory(_ newItem: String?) -> [String: [String]] {
        var groupedByType = [String: [String]]()
        var items: [String] {
            var correctCase = [String]()
            for item in store.user.fridge {
                correctCase.append(item.capitalized)
                if let newItem = newItem {
                    correctCase.append(newItem.capitalized)
                }
            }
            return correctCase
        }

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
        foodCollection.removeAll()
        for (key, value) in groupedItems {
            let foodGroup = FoodGroups(groupName: key, groupItems: value)
            foodCollection.append(foodGroup)
        }
    }


}
