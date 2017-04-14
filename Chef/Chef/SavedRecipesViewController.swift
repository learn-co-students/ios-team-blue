import UIKit

class SavedRecipesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let store = RecipeDataStore.shared
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
        self.navigationItem.title = "Saved Recipes"

        self.store.updateSavedRecipes() {
            DispatchQueue.main.async {
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
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