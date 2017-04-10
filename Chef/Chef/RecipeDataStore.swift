import Foundation
import SwiftyJSON

final class RecipeDataStore {

    static let sharedInstance = RecipeDataStore()
    var recipes = [Recipe]()

    private init() {}

    func getRecipes(user: User, _ completion: @escaping () -> ()) {
        SpoonacularAPIClient.generateRecipes(for: user) { (result) in
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
                guard let completeRecipe = completeRecipe as? [String: Any] else {
                    return
                }
                guard let analyzedInstructions = completeRecipe["analyzedInstructions"] as? [[String: Any]] else {return}
                guard let steps = analyzedInstructions[0]["steps"] as? [[String: Any]] else {return}
                for step in steps {

                    guard let singleStep = step["step"] as? String else {return}
                    stepsArray.append(singleStep)
                }

                recipe.instructions = stepsArray
                //print("THE STEPS ARE", recipe.instructions ?? "No instructions")
                completion()

            case .failure(let error):
                print(error)

            }
        }

    }

}
