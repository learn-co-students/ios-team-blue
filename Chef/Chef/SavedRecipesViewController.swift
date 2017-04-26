import UIKit

class SavedRecipesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, RecipeCellDelegate {

    let store = RecipeDataStore.shared
    var collectionView: UICollectionView!
    var loadingView: RecipeLoadingView!


    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
        self.navigationItem.title = "Saved Recipes"

        print("\nSavedRecipesViewController.\(#function) -- Fetching saved recipes for first time")
        self.refreshView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // should probably be doing a check to see if anything changed
        // TODO: - RefreshView shouldn't be getting called twice when view loads
        self.refreshView()
    }

    func refreshView() {
        self.store.fetchSavedRecipes { success in
            if success {
                DispatchQueue.main.async {
                    print("SavedRecipesViewController.\(#function) -- Reloading collection view")
                    self.loadingView.indicator.stopAnimating()
                    UIView.animate(withDuration: 0.6, animations: {
                        self.loadingView.alpha = 0.0
                        self.collectionView.alpha = 1.0
                    })
                    self.collectionView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    print("SavedRecipesViewController.\(#function) -- There was a failure, ending animation")
                    self.loadingView.indicator.stopAnimating()
                    UIView.animate(withDuration: 0.6, animations: {
                        self.loadingView.alpha = 0.0
                        self.collectionView.alpha = 1.0
                    })
                }
            }
        }
    }


    // MARK: - Recipe Cell Delegate

    func heartButtonTapped(_ sender: RecipeCell) {
        print("\nSavedRecipesViewController.\(#function)")
        let recipe = sender.recipe!
        self.store.removeSavedRecipe(recipe) {
            DispatchQueue.main.async {
                print("SavedRecipesViewController.\(#function) -- Reloading data")
                self.collectionView.reloadData()
            }
        }
    }


    // MARK: - Data Source

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.store.savedRecipes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipeCell
        cell.recipe = self.store.savedRecipes[indexPath.row]
        cell.delegate = self
        return cell
    }


    // MARK: - Delegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeVC = RecipeDetailViewController()
        recipeVC.recipe = self.store.savedRecipes[indexPath.row]
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
            cv.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
            cv.alpha = 0.0
            return cv
        }()
        self.view.addSubview(self.collectionView)

        self.loadingView = {
            let rlv = RecipeLoadingView()
            rlv.indicator.startAnimating()
            return rlv
        }()

        self.view.addSubview(self.loadingView)
        self.loadingView.snapToSuperview()
    }

}
