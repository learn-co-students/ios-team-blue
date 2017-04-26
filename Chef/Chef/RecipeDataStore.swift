import Foundation
import Firebase

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
                    var savedIDs = [String]()
                    for recipeID in self.user.favRecipes {
                        savedIDs.append(recipeID)
                    }
                    if let recipe = Recipe(dictionary: dictionary) {
                        if savedIDs.contains(recipe.id) {
                            recipe.isFavorite = true
                        }
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
    func fetchSavedRecipes(completion: @escaping (Bool) -> ()) {
        print("RecipeDataStore.\(#function) -- fetching saved recipes from Spoonacular")

        SpoonacularAPIClient.fetchSavedRecipes(ids: self.user.favRecipes) { result in
            switch result {
            case .success(let recipes):
                print("RecipeDataStore.\(#function) -- Success")
                guard let recipes = recipes as? [Recipe] else {
                    print("RecipeDataStore.\(#function) -- Casting failed")
                    return
                }
                self.savedRecipes = recipes
                completion(true)
            case .failure(let error):
                print("RecipeDataStore.\(#function) -- Failure: \(error)")
                completion(false)
            }
        }
    }

    /// Adds recipe to firebase and refreshes
    func addSavedRecipe(_ recipe: Recipe, completion: @escaping () -> ()) {
        print("RecipeDataStore.\(#function) -- Adding saved recipe to firebase")

        // make new array for saved recipes that includes the new recipe
        var newSavedRecipes = [Recipe]()
        for savedRecipe in self.savedRecipes {
            newSavedRecipes.append(savedRecipe)
        }
        newSavedRecipes.append(recipe)

        // make dictionary from newSavedRecipes array
        var savedRecipeDict = JSONDictionary()
        for (index, recipe) in newSavedRecipes.enumerated() {
            savedRecipeDict["\(index)"] = recipe.id
        }

        FirebaseManager.setFavoriteRecipes(savedRecipeDict, for: self.user)

        self.refreshUser() {
            self.fetchSavedRecipes() { _ in
                completion()
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
            self.fetchSavedRecipes() { _ in
                completion()
            }
        }
    }

    func updateFridge(with newItems: [String]) {
        var existingIngredients = self.user.fridge
        print("The existing ingredients are ", existingIngredients)
        for item in newItems {
            if !existingIngredients.contains(item) {
                existingIngredients.append(item)
            }
        }
        print("The combined ingredients are ", existingIngredients)
        var dictUpdate = JSONDictionary()
        for (index, item) in existingIngredients.enumerated() {
            dictUpdate["\(index)"] = item
        }
        FirebaseManager.setIngredients(dictUpdate, for: self.user) { 
            self.refreshUser(completion: {
                print(self.user)
            })
        }
    }

    func updateDiet(with newItems: [String]) {
        var existingDiets = self.user.dietList
        print("The existing diets are ", existingDiets)
        for item in newItems {
            if !existingDiets.contains(item) {
                existingDiets.append(item)
            }
        }
        print("The combined diets are ", existingDiets)
        var dictUpdate = JSONDictionary()
        for (index, item) in existingDiets.enumerated() {
            dictUpdate["\(index)"] = item
        }
        FirebaseManager.addDietaryRestrictions(dictUpdate, to: self.user) {
            self.refreshUser(completion: nil)
        }
    }

    func updateAllergy(with newItems: [String]) {
        var existingAllergies = user.allergyList
        print("The existing allergies are ", existingAllergies)

        for item in newItems {
            if !existingAllergies.contains(item) {
                existingAllergies.append(item)
            }
        }
        print("The combined allergies are ", existingAllergies)
        var dictUpdate = JSONDictionary()
        for (index, item) in existingAllergies.enumerated() {
            dictUpdate["\(index)"] = item
        }
        FirebaseManager.addAllergy(dictUpdate, to: self.user) {
            self.refreshUser(completion: nil)
        }
    }

    func deleteIngredient(_ item: String, completion: () -> ()) {
        let fridge = self.user.fridge
        let filteredFridge = fridge.filter{ $0 != item }
        var dictUpdate = JSONDictionary()
        for (index, item) in filteredFridge.enumerated() {
            dictUpdate["\(index)"] = item
        }
        FirebaseManager.setIngredients(dictUpdate, for: self.user) { 
            self.refreshUser(completion: nil)
        }
    }

}
