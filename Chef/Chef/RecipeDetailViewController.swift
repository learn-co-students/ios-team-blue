import UIKit
import SnapKit

class RecipeDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RecipeCellImageViewDelegate {

    var foodImageView: UIImageView!
    var tableView: UITableView!
    var foodImage: UIImage?

    var recipe: Recipe! {
        didSet {
            self.navigationItem.title = self.recipe.title
            self.retrieveRecipeInfo {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeUI()
    }

    func retrieveRecipeInfo(completion: @escaping () -> ()) {
        SpoonacularAPIClient.fetchRecipeDetail(id: recipe.id) { result in
            switch result {
            case .success(let recipeDetail):
                let recipeDetail = recipeDetail as! JSONDictionary
                self.recipe.addDetail(dictionary: recipeDetail)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }


    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.recipe != nil ? self.recipe.ingredients.count : 0
        case 2:
            return self.recipe != nil ? self.recipe.instructions.count : 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none

        switch indexPath.section {
        case 0: // special cell
            if self.recipe != nil {
                cell.textLabel?.font = Fonts.medium16
                cell.textLabel?.text = "Servings: \(self.recipe.servings)        Cook Time: \(self.recipe.cookTime) min."
            } else {
                break
            }
        case 1: // ingredients cell
            if self.recipe != nil {
                cell.textLabel?.font = Fonts.medium16
                cell.textLabel?.text = self.recipe.ingredients[indexPath.row]
            } else {
                break
            }
        case 2: // instructions cell
            if self.recipe != nil {
                cell.textLabel?.font = Fonts.medium16
                cell.textLabel?.text = self.recipe.instructions[indexPath.row]
            } else {
                break
            }
        default:
            break
        }
        return cell
    }


    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1, 2:
            return CGFloat(RecipeDetailSectionHeaderView.height)
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let headerView = RecipeDetailSectionHeaderView()
            headerView.label.text = " Ingredients"
            return headerView
        case 2:
            let headerView = RecipeDetailSectionHeaderView()
            headerView.label.text = " Instructions"
            return headerView
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Ingredients"
        case 2:
            return "Instructions"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 2:
            return self.tabBarController?.tabBar.bounds.height ?? 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 2:
            let footer = UIView()
            footer.backgroundColor = .white
            return footer
        default:
            return nil
        }
    }


    // MARK: - UI

    func makeUI() {
        self.view.backgroundColor = .white
        self.createUI()
        self.constrainUI()
    }

    func createUI() {
        self.foodImageView = {
            let iv = UIImageView()
            iv.image = self.foodImage ?? UIImage(named: "bird")!
            return iv
        }()
        self.view.addSubview(self.foodImageView)

        self.tableView = {
            let tv = UITableView()
            tv.dataSource = self
            tv.delegate = self
            tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            tv.separatorStyle = .none
            tv.backgroundColor = .clear
            return tv
        }()
        self.view.addSubview(self.tableView)
    }

    func constrainUI() {
        self.foodImageView.snp.makeConstraints { make in
            make.left.top.width.equalToSuperview()
            make.height.equalTo(self.view.snp.width)
        }

        self.tableView.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalToSuperview().offset(190)
            make.bottom.equalToSuperview()
        }
    }


    // MARK: - RecipeCellImageViewDelegate

    func didReceiveImage(_ image: UIImage?) {
        self.foodImage = image
    }

}
