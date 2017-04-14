import Foundation
import Alamofire
import SwiftyJSON

typealias JSONDictionary = [String: Any]

final class SpoonacularAPIClient {

    private static let baseURL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients="
    private static let otherInfoURL = "&limitLicense=false&number=20&ranking=1"

    class func generateRecipes(for user: User, completion: @escaping (SpoonacularAPIClientResponse) -> ()) {
        //If the user has no dietary restriction/intolerances
        if user.allergyList?.isEmpty == false && user.dietList?.isEmpty == false {
            let ingredients = Helper.spoonacularEncode(items: user.fridge)
            let url = baseURL + ingedients + otherInfoURL
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
        } else {
            //If the user does have diet/intolerances
            let allergies = Helper.spoonacularEncode(items: user.allergyList)
            let diets = Helper.spoonacularEncode(items: user.dietList)
            let ingredients = Helper.spoonacularEncode(items: user.fridge)
            let exampleURL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex?addRecipeInformation=true&diet=\(diets)&fillIngredients=false&includeIngredients=\(ingredients)&instructionsRequired=true&intolerances=\(allergies)&limitLicense=false&number=100&offset=0&ranking=2"
            

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
                    let recipe = Recipe(dictionary: responseJSON)
                    completion(.success(recipe))
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

}

class Helper {

    static func spoonacularEncode(items: [String]) -> String {
        var container  = ""
        for item in items {
            if item == items.first {
                container += item
            } else {
                container += "%2C\(item)"
            }
        }
        return container
    }
}
