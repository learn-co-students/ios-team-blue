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
                    if let recipe = Recipe(dictionary: dictionary) {
                        self.recipes.append(recipe)
                    } else {
                        print("recipe skipped")
                    }
                }
                completion()
            case .failure(let error):
                print(error)
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

    func pullDataForUser(_ user: User, completion: @escaping () ->()) {
        FirebaseManager.getUserData(user) { (recipeIDs, food) in
            for id in recipeIDs {
                self.user.favRecipes.append(id)
            }
            self.user.fridge = food
            completion()
        }
    }

}
