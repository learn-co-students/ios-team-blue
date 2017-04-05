import Foundation

final class RecipeDataStore {

    static let sharedInstance = RecipeDataStore()
    private init() {}

    static var myRecipes = [Dish]()


    static func getRecipes(user: User, _ completion: @escaping () -> ()) {
        RecipeAPIClientManager.generateRecipes(for: user) { (recipeList) in
            self.myRecipes.removeAll()
            for dictionary in recipeList {
                let dish = Dish(dictionary: dictionary)
                self.myRecipes.append(dish)
            }
            
            completion()
        }
    }



}
