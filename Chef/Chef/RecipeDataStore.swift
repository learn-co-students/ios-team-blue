import Foundation

final class RecipeDataStore {

    static let sharedInstance = RecipeDataStore()
    private init() {}

    static var myRecipes = [Recipe]() 

    static func getRecipes(user: User, _ completion: @escaping () -> ()) {
        SpoonacularAPIClient.generateRecipes(for: user) { (result) in
            switch result {
            case .success(let recipeList):
                guard let recipeList = recipeList as? [[String: Any]] else {fatalError("Not an array of dictionaries")}
                self.myRecipes.removeAll()
                for dictionary in recipeList {
                    let recipe = Recipe(dictionary: dictionary)
                    self.myRecipes.append(recipe)
                }
                completion()
            case .failure(let error):
                print(error)

            }
        }
    }

    static func getRecipeLink(recipe: Recipe, _ completion: @escaping (URL) -> ()) {
        SpoonacularAPIClient.generateRecipeByID(for: recipe) { (result) in
            switch result {
            case .success(let url):
                guard let url = url as? URL else {fatalError("Not valid URL")}
                completion(url)
            case .failure(let error):
                print(error)
            }
        }
    }

}
