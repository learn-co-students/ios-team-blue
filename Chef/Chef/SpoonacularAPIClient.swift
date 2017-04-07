import Foundation
import Alamofire

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
            print(response.result.value ?? "No value")
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
                print("JSON Result: \(JSON)")
                joke = "\(JSON)"
            }
        }
        return joke
    }

    class func generateRecipeByID(for recipe: Recipe, completion: @escaping (SpoonacularAPIClientResponse) -> ()) {
        let endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/\(recipe.id)/information?includeNutrition=false"
        Alamofire.request(endpoint, method: .get, headers: spoonacularAPIHeaders).responseJSON {
            (response) in
            print("NEW OBJC's response: \(response.result.value)")
            if let json = response.result.value {
                if let responseJSON = json as? [String: Any] {
                    guard let stringToLink = responseJSON["sourceURL"] as? String,
                     let url = URL(string: stringToLink) else {fatalError("Not a valid link!")}
                    completion(.success(url))

                } else {
                    completion(.failure(.nodata))
                }
            }
        }
    }

}
