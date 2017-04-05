import Foundation
import Alamofire

enum RecipeAPIClientManagerResponse {
    case success(Any)
    case failure(RecipeAPIClientManagerError)
}

enum RecipeAPIClientManagerError: Error {
    case nodata
}

final class RecipeAPIClientManager {

    class func generateRecipes(for user: User, completion: @escaping ( [[String : Any]] ) -> ()) {
        var container = ""
        for ingredient in user.fridge {
            if ingredient == user.fridge.first {
                container += ingredient
            } else {
                container += "%2C\(ingredient)"
            }
        }
        let endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients=\(container)&limitLicense=false&number=5&ranking=1"
        print("The endpoint is: \(endpoint)")
        Alamofire.request(endpoint, method: .get, headers: spoonacularAPIHeaders).responseJSON {
            (response) in
            print(response.result.value ?? "No value")
            if let json = response.result.value {
                if let responseJSON = json as? [[String: Any]] {
                completion(responseJSON)
                }
            }
        }
    }

    class func generateRecipes2(for user: User, completion: @escaping (RecipeAPIClientManagerResponse) -> ()) {
        var container = ""
        for ingredient in user.fridge {
            if ingredient == user.fridge.first {
                container += ingredient
            } else {
                container += "%2C\(ingredient)"
            }
        }
        let endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients=\(container)&limitLicense=false&number=5&ranking=1"
        print("The endpoint is: \(endpoint)")
        Alamofire.request(endpoint, method: .get, headers: spoonacularAPIHeaders).responseJSON {
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

    class func randomJoke() -> String{
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



}






