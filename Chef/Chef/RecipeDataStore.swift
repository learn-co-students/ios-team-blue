import Foundation
import SwiftyJSON

final class RecipeDataStore {

    static let shared = RecipeDataStore()
    var user = User()
    var recipes = [Recipe]()
    var savedRecipes = [Recipe]()

    private init() {}

    func setUser(_ user: User) {
        self.user = user
    }

    func getRecipes(_ completion: @escaping () -> ()) {

        SpoonacularAPIClient.generateRecipes(for: self.user) { (result) in
            switch result {
            case .success(let recipeList):
                guard let recipeList = recipeList as? [[String: Any]] else {
                    return
                }
                self.recipes.removeAll()
                for dictionary in recipeList {
                    let recipe = Recipe(dictionary: dictionary)
                    self.recipes.append(recipe)
                }
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

    static func getRecipeSteps(recipe: Recipe, _ completion: @escaping () -> ()) {
        SpoonacularAPIClient.generateRecipeByID(for: recipe) { (result) in
            var stepsArray = [String]()

            switch result {
            case .success(let completeRecipe):
                guard let completeRecipe = completeRecipe as? [String: Any],
                      let analyzedInstructions = completeRecipe["analyzedInstructions"] as? [[String: Any]],
                      let steps = analyzedInstructions[0]["steps"] as? [[String: Any]] else { return }

                for step in steps {
                    guard let singleStep = step["step"] as? String else { return }
                    stepsArray.append(singleStep)
                }

                recipe.instructions = stepsArray
                //print("\nRECIPE INSTRUCTIONS\n", recipe.instructions ?? "No instructions")
                completion()

            case .failure(let error):
                print(error)
            }
        }
    }

    func pullDataForUser(_ user: User, completion: @escaping () ->()) {
        FirebaseManager.getUserData(user) { (recipeIDs, food) in
            for id in recipeIDs {
                self.user.favRecipes.append(Int(id)!)
            }
            self.user.fridge = food
            completion()
        }
    }

}
