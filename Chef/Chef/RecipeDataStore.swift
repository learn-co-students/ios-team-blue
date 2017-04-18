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
        print("We are getting recipes!")
        SpoonacularAPIClient.generateRecipes(for: self.user) { (result) in
            switch result {
            case .success(let recipeList):
                print("We succesfully got the recipes!")
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
                print("We did not get the recipes :(")
                print("The error is ", error)
            }
        }
    }

    func updateSavedRecipes(completion: @escaping () -> ()) {
        SpoonacularAPIClient.fetchSavedRecipes(for: self.user) { result in
            switch result {
            case .success(let recipes):
                guard let recipes = recipes as? [Recipe] else {
                    print(#function + " casting failed")
                    return
                }
                self.savedRecipes = recipes
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
        FirebaseManager.getUserData(user) { (recipeIDs, food, allergies, diet) in
            for id in recipeIDs {
                self.user.favRecipes.append(id)
            }

            if let allergyList = allergies {
                for item in allergyList {
                    self.user.allergyList.append(item)
                }
            }
            if let dietList = diet {
                for item in dietList {
                    self.user.dietList.append(item)
                }
            }

            self.user.fridge = food
            completion()
        }
    }

}
