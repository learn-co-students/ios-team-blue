import UIKit

class GenerateRecipesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, RecipeCellDelegate {

    let store = RecipeDataStore.shared
    var collectionView: UICollectionView!
    var isFirstTimeLoggingIn: Bool = false


    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
        self.navigationItem.title = "My Cookbook"

        print("\nGenerateRecipesViewController.\(#function) -- Generating recipes for first time")
        self.store.fetchGeneratedRecipesFromSpoonacular {
            DispatchQueue.main.async {
                print("GenerateRecipesViewController.\(#function) -- Reloading collection view")
                self.collectionView.reloadData()
            }
        }

        if self.isFirstTimeLoggingIn {
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TutorialViewController") as UIViewController
            self.present(viewController, animated: false, completion: nil)
        }
    }


    // MARK: - Recipe Cell Delegate

    func heartButtonTapped(_ sender: RecipeCell) {
        print("\nGenerateRecipesViewController.\(#function)")
        let recipe = sender.recipe!
        if recipe.isFavorite {
            self.store.addSavedRecipe(recipe) {}
        } else {
            self.store.removeSavedRecipe(recipe) {}
        }
    }


    // MARK: - Data Source

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.store.generatedRecipes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipeCell
        cell.recipe = self.store.generatedRecipes[indexPath.row]
        cell.delegate = self
        return cell
    }


    // MARK: - Delegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeVC = RecipeDetailViewController()
        recipeVC.recipe = self.store.generatedRecipes[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) as? RecipeCell {
            cell.imageViewDelegate = recipeVC
        }
        self.navigationController?.pushViewController(recipeVC, animated: true)
    }

    // MARK: - UI

    func createUI() {
        let spacing = CGFloat(8)
        let cellWidth = self.view.bounds.width / 2 - CGFloat(1.5 * spacing)
        let cellHeight = cellWidth * 1.8
        let cellSize = CGSize(width: cellWidth, height: cellHeight)

        let layout: UICollectionViewFlowLayout = {
            let cvfl = UICollectionViewFlowLayout()
            cvfl.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            cvfl.itemSize = cellSize
            cvfl.minimumLineSpacing = spacing
            cvfl.minimumInteritemSpacing = spacing
            return cvfl
        }()

        self.collectionView = {
            let cv = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            cv.dataSource = self
            cv.delegate = self
            cv.register(RecipeCell.self, forCellWithReuseIdentifier: "recipeCell")
            cv.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            return cv
        }()

        self.view.addSubview(self.collectionView)
    }

}
