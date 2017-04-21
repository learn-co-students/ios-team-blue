import Foundation
import SwiftyJSON

final class RecipeDataStore {

    static let shared: RecipeDataStore = RecipeDataStore()
    private(set) var user: User!
    var generatedRecipes: [Recipe] = [Recipe]()
    var savedRecipes: [Recipe] = [Recipe]()

    private init() {}

    /// This function should be called once the user has been validated.
    /// Posts to firebase and refreshes
    /// If the user has just signed up, add user to database. Otherwise
    func setUser(_ user: User, completion: @escaping () -> ()) {
        print("RecipeDataStore.\(#function) -- Setting user")
        self.user = user
        FirebaseManager.checkIfUserExists(user) { userAlreadyExists in
            if userAlreadyExists {
                self.refreshUser() {
                    completion()
                }
            } else {
                FirebaseManager.addUser(user)
                completion()
            }
        }
    }

    /// Goes to firebase and fetches the data for the current user
    private func refreshUser(completion: (() -> ())?) {
        print("RecipeDataStore.\(#function) -- Refreshing user data from Firebase")
        FirebaseManager.getUserData(user) { recipes, foods, dietaryRestrictions, allergies in
            self.user.favRecipes = recipes
            self.user.fridge = foods
            if let dietaryRestrictions = dietaryRestrictions {
                self.user.dietList = dietaryRestrictions
            }
            if let allergies = allergies {
                self.user.allergyList = allergies
            }
            completion?()
        }
    }

    /// Goes to spoonacular and sets the proper current generated recipes
    func fetchGeneratedRecipesFromSpoonacular(_ completion: @escaping () -> ()) {
        print("RecipeDataStore.\(#function) -- Fetching generated recipes from Spoonacular")
        // MARK: - Should be generateRecipes(ids: ) and should return me recipes
        SpoonacularAPIClient.generateRecipes(for: self.user) { result in
            switch result {
            case .success(let recipeList):
                print("RecipeDataStore.\(#function) -- Success")
                guard let recipeList = recipeList as? [[String: Any]] else {
                    return
                }
                self.generatedRecipes.removeAll()
                for dictionary in recipeList {
                    if let recipe = Recipe(dictionary: dictionary) {
                        self.generatedRecipes.append(recipe)
                    } else {
                        print("RecipeDataStore.\(#function) -- Recipe was filtered out")
                    }
                }
                completion()
            case .failure(let error):
                print("RecipeDataStore.\(#function) -- Failure: \(error)")
            }
        }
    }

    /// Goes to spoonacular and sets the proper current generated recipes
    /// Occurs after hearting or unhearting an object, I think?
    func fetchSavedRecipes(completion: @escaping () -> ()) {
        print("RecipeDataStore.\(#function) -- fetching saved recipes from Spoonacular")
        // MARK: - THIS IS WHERE THE PROBLEM WAS BEFORE
        SpoonacularAPIClient.fetchSavedRecipes(ids: self.user.favRecipes) { result in
            switch result {
            case .success(let recipes):
                print("RecipeDataStore.\(#function) -- Success")
                guard let recipes = recipes as? [Recipe] else {
                    print("RecipeDataStore.\(#function) -- Casting failed")
                    return
                }
                self.savedRecipes = recipes
                completion()
            case .failure(let error):
                print("RecipeDataStore.\(#function) -- Failure: \(error)")
            }
        }
    }

    /// Removes recipe from firebase and refreshes
    func removeSavedRecipe(_ recipe: Recipe, completion: @escaping () -> ()) {
        print("RecipeDataStore.\(#function) -- Removing saved recipe from firebase")

        // make new array for saved recipes that doesn't include the removed recipe
        var newSavedRecipes = [Recipe]()
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

        FirebaseManager.setFavoriteRecipes(savedRecipeDict, for: self.user)

        self.refreshUser() {
            self.fetchSavedRecipes() {
                completion()
            }
        }
    }

}
