import UIKit
import SnapKit

class RecipeDetailViewController: UIViewController {

    let store = RecipeDataStore.shared
    var recipeView: RecipeView!
    var fullRecipe: FullRecipe!

    var recipe: Recipe! {
        didSet {
            retrieveRecipeInfo()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.recipeView = RecipeView(frame: .zero)
        self.recipeView.navBarHeight = self.navigationController!.navigationBar.frame.height

        self.view.addSubview(self.recipeView)
        self.recipeView.snapToSuperview()
    }

    func retrieveRecipeInfo() {
        SpoonacularAPIClient.fetchFullRecipe(id: recipe.id) { result in
            switch result {
            case .success(let fullRecipe):
                self.fullRecipe = fullRecipe as! FullRecipe
                self.recipeView.textView.text = self.fullRecipe.instructions
            case .failure(let error):
                print(error)
            }
        }
    }

}
