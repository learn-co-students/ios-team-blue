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
        print("RecipeDataStore -- \(#function)")

        SpoonacularAPIClient.generateRecipes(for: self.user) { result in
            switch result {
            case .success(let recipeList):
                print("RecipeDataStore -- \(#function) -- Success")
                guard let recipeList = recipeList as? [[String: Any]] else {
                    return
                }
                self.recipes.removeAll()
                for dictionary in recipeList {
                    if let recipe = Recipe(dictionary: dictionary) {
                        self.recipes.append(recipe)
                    } else {
                        print("RecipeDataStore -- \(#function) -- Recipe was filtered out")
                    }
                }
                completion()
            case .failure(let error):
                print("RecipeDataStore -- \(#function) -- Error: \(error)")
            }
        }
    }

    func updateSavedRecipes(completion: @escaping () -> ()) {
        print("RecipeDataStore -- \(#function)")

        SpoonacularAPIClient.fetchSavedRecipes(for: self.user) { result in
            switch result {
            case .success(let recipes):
                guard let recipes = recipes as? [Recipe] else {
                    print("RecipeDataStore -- \(#function) -- Casting failed")
                    return
                }
                self.savedRecipes = recipes
                print("RecipeDataStore -- \(#function) -- updatingSavedRecipes")
                completion()
            case .failure(let error):
                print("RecipeDataStore -- \(#function) -- Error: \(error)")
            }
        }
    }

    func removeSavedRecipe(_ recipe: Recipe, completion: @escaping () -> ()) {
        print("RecipeDataStore -- \(#function)")

        var newSavedRecipes = [Recipe]()

        // make new array for saved recipes that doesn't include the remove recipe
        for savedRecipe in self.savedRecipes {
            if recipe.id != savedRecipe.id {
                newSavedRecipes.append(savedRecipe)
            }
        }

        // make dictionary from newSavedRecipes array
        var savedRecipeDict = JSONDictionary()
        for (index, recipe) in newSavedRecipes.enumerated() {
            savedRecipeDict["\(index)"] = recipe.id
        }

        //FirebaseManager.setSavedRecipes(savedRecipeDict, for: self.user)

        self.updateSavedRecipes {
            completion()
        }
    }

    func pullDataForUser(_ user: User, completion: @escaping () ->()) {
        print("RecipeDataStore -- \(#function)")

        FirebaseManager.getUserData(user) { (recipeIDs, food, diet, allergies) in
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
