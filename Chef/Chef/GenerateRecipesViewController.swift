import UIKit

class GenerateRecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let store = RecipeDataStore.sharedInstance
    var tableView: UITableView!
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

        self.user = User(name: "person@gmail.com", favRecipes: [], fridge: ["bread", "cheese", "oil", "lentils", "chicken", "pasta", "ramen", "tomatoes", "pomegranate"])

        self.store.getRecipes(user: user) {
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
        return self.store.recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeCell

        let recipe = self.store.recipes[indexPath.row]

        cell.imgView.image = UIImage(named: "bird")
        cell.nameLabel.text = recipe.title

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
