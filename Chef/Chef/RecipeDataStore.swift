import Foundation

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

    func getRecipeLink(recipe: Recipe, _ completion: @escaping (URL) -> ()) {
        SpoonacularAPIClient.generateRecipeByID(for: recipe) { (result) in
            switch result {
            case .success(let url):
                guard let url = url as? URL else {
                    return
                }
                completion(url)
            case .failure(let error):
                print(error)
            }
        }
    }

}
