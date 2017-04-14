import UIKit

class SavedRecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let store = RecipeDataStore.shared
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
        self.navigationItem.title = "Saved Recipes"

        self.store.updateSavedRecipes() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


    // MARK: - Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.savedRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeCell

        let recipe = self.store.savedRecipes[indexPath.row]

        cell.nameLabel.text = recipe.title

        let url = URL(string: recipe.imageLink)
        cell.imgView.kf.setImage(with: url,
                                 placeholder: nil,
                                 options: [.transition(.fade(2))],
                                 progressBlock: nil,
                                 completionHandler: nil)

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
        self.tableView.register(RecipeCell.self, forCellReuseIdentifier: "recipeCell")
        self.view.addSubview(self.tableView)
    }
    
}
