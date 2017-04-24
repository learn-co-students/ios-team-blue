import UIKit
import SnapKit

class RecipeDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RecipeCellImageViewDelegate {

    var foodImageView: UIImageView!
    var tableView: UITableView!
    var foodImage: UIImage?
    var loadingView: RecipeDetailLoadingView!

    var recipe: Recipe! {
        didSet {
            self.retrieveRecipeInfo {
                self.loadingView.indicator.stopAnimating()
                UIView.animate(withDuration: 0.6, animations: {
                    self.loadingView.alpha = 0.0
                })
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
        if self.recipe.ingredients == [] {
            return 0
        } else {
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
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeDetailCell", for: indexPath) as! RecipeDetailCell

        switch indexPath.section {
        case 0: // special cell
            if self.recipe != nil {
                cell.numLabel.text = ""
                cell.label.text = "Serves: \(self.recipe.servings)        Cook Time: \(self.recipe.cookTime) min."
            } else {
                break
            }
        case 1: // ingredients cell
            if self.recipe != nil {
                cell.numLabel.text = "\(indexPath.row + 1)."
                cell.label.text = self.recipe.ingredients[indexPath.row]
            } else {
                break
            }
        case 2: // instructions cell
            if self.recipe != nil {
                cell.numLabel.text = "\(indexPath.row + 1)."
                cell.label.text = self.recipe.instructions[indexPath.row]
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
        if self.recipe.ingredients != [] {
            switch section {
            case 1, 2:
                return CGFloat(RecipeDetailSectionHeaderView.height)
            default:
                return 0
            }
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.recipe.ingredients != [] {
            switch section {
            case 1:
                let headerView = RecipeDetailSectionHeaderView()
                headerView.label.text = "Ingredients"
                return headerView
            case 2:
                let headerView = RecipeDetailSectionHeaderView()
                headerView.label.text = "Instructions"
                return headerView
            default:
                return nil
            }
        } else {
            return nil
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
        self.navigationController?.navigationBar.tintColor = Colors.flatironBlue

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
            tv.register(RecipeDetailCell.self, forCellReuseIdentifier: "recipeDetailCell")
            tv.separatorStyle = .none
            tv.backgroundColor = .clear
            let frame = CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: RecipeDetailHeaderView.height)
            let thv = RecipeDetailHeaderView(frame: frame)
            thv.label.text = self.recipe.title
            tv.tableHeaderView = thv
            tv.rowHeight = UITableViewAutomaticDimension
            tv.estimatedRowHeight = 140
            return tv
        }()
        self.view.addSubview(self.tableView)

        self.loadingView = {
            let size = CGSize(width: self.view.bounds.width, height: 200)
            let frame = CGRect(origin: CGPoint.zero, size: size)
            let lv = RecipeDetailLoadingView(frame: frame)
            lv.indicator.startAnimating()
            return lv
        }()
        self.view.addSubview(self.loadingView)
    }

    func constrainUI() {
        self.foodImageView.snp.makeConstraints { make in
            make.left.top.width.equalToSuperview()
            make.height.equalTo(self.view.snp.width)
        }

        self.tableView.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalToSuperview().offset(215)
            make.bottom.equalToSuperview()
        }

        self.loadingView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.tableView.snp.top).offset(RecipeDetailHeaderView.height)
            make.bottom.equalToSuperview().offset(-49)
        }
    }


    // MARK: - RecipeCellImageViewDelegate

    func didReceiveImage(_ image: UIImage?) {
        self.foodImage = image
    }

}
