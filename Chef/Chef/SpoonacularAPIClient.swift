import Foundation
import Alamofire
import SwiftyJSON

typealias JSONDictionary = [String: Any]

final class SpoonacularAPIClient {

    private static let baseURL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients="
    private static let otherInfoURL = "&limitLicense=false&number=20&ranking=1"

    class func generateRecipes(for user: User, completion: @escaping (SpoonacularAPIClientResponse) -> ()) {
        var container = ""
        for ingredient in user.fridge {
            if ingredient == user.fridge.first {
                container += ingredient
            } else {
                container += "%2C\(ingredient)"
            }
        }

        let url = baseURL + container + otherInfoURL

        Alamofire.request(url, method: .get, headers: spoonacularAPIHeaders).responseJSON {
            (response) in
            if let json = response.result.value {
                if let responseJSON = json as? [[String: Any]] {
                    completion(.success(responseJSON))
                } else {
                    completion(.failure(.nodata))
                }
            }
        }
    }

    class func randomJoke() -> String {
        let endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/jokes/random"
        var joke = ""
        Alamofire.request(endpoint, method: .get,headers: spoonacularAPIHeaders).responseJSON {
            (response) in
            if let JSON = response.result.value {
                joke = "\(JSON)"
            }
        }
        return joke
    }

    class func generateRecipeByID(for recipe: Recipe, completion: @escaping (SpoonacularAPIClientResponse) -> ()) {
        let endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/\(recipe.id)/information?includeNutrition=false"
        Alamofire.request(endpoint, method: .get, headers: spoonacularAPIHeaders).responseJSON {
            (response) in
            if let json = response.result.value {
                if let responseJSON = json as? [String: Any] {
                    completion(.success(responseJSON))

                } else {
                    completion(.failure(.nodata))
                }
            }
        }
    }

    class func fetchRecipe(id: String, completion: @escaping (SpoonacularAPIClientResponse) -> ()) {
        let endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/\(id)/information?includeNutrition=false"
        Alamofire.request(endpoint, method: .get, headers: spoonacularAPIHeaders).responseJSON { response in
            if let json = response.result.value {
                if let responseJSON = json as? JSONDictionary {
                    if let recipe = Recipe(dictionary: responseJSON) {
                        completion(.success(recipe))
                    } else {
                        print(#function + " -- skipped recipe")
                    }
                } else {
                    completion(.failure(.nodata))
                }
            }
        }
    }

    static func fetchSavedRecipes(for user: User, completion: @escaping (SpoonacularAPIClientResponse) -> ()) {
        var recipes = [Recipe]()
        for id in user.favRecipes {
            self.fetchRecipe(id: id) { result in
                switch result {
                case .success(let recipe):
                    guard let recipe = recipe as? Recipe else { return }
                    recipes.append(recipe)
                    completion(SpoonacularAPIClientResponse.success(recipes))
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    static func fetchRecipeDetail(id: String, completion: @escaping (SpoonacularAPIClientResponse) -> ()) {
        let endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/\(id)/information?includeNutrition=false"
        Alamofire.request(endpoint, method: .get, headers: spoonacularAPIHeaders).responseJSON { response in
            guard let recipeDetail = response.result.value as? JSONDictionary else {
                completion(.failure(SpoonacularAPIClientError.nodata))
                return
            }
            completion(.success(recipeDetail))
        }
    }

    static func parseIngredients(_ json: [JSONDictionary]) -> [String] {
        var ingredients = [String]()
        for entry in json {
            guard let ingredient = entry["originalString"] as? String else {
//                print(#function + " -- failed")
                fatalError(#function + " -- failed")
            }
            ingredients.append(ingredient)
        }

        return ingredients
    }

    static func parseInstructions(_ json: [JSONDictionary]) -> [String] {
        var instructions = [String]()

        let instructionsArray = json[0]

        guard let steps = instructionsArray["steps"] as? [JSONDictionary] else {
            fatalError(#function + " -- failed")
        }

        for step in steps {
            guard let instruction = step["step"] as? String else {
                fatalError()
            }
            instructions.append(instruction)
        }

        return instructions
    }

}
