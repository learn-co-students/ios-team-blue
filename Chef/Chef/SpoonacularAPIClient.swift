import Foundation
import UIKit
import Alamofire
import SwiftyJSON

final class SpoonacularAPIClient {

    private static let baseURL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients="
    private static let otherInfoURL = "&limitLicense=false&number=20&ranking=1"

    class func generateRecipes(for user: User, completion: @escaping (SpoonacularAPIClientResponse) -> ()) {

        //If the user has no dietary restriction/intolerances
        if user.allergyList.isEmpty && user.dietList.isEmpty {
             print("Doin the standard call")
            let ingredients = Helper.spoonacularEncode(items: user.fridge)
            let url = baseURL + ingredients + otherInfoURL
            print("The full URL is ", url)
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
            let ingredients = Helper.spoonacularEncode(items: user.fridge)
            var allergyList = ""
            var dietList = ""

            if !user.dietList.isEmpty{
                let diets = Helper.spoonacularEncode(items: user.dietList)
                dietList = "&diet=\(diets)"
            }
            if !user.allergyList.isEmpty {
                let allergies = Helper.spoonacularEncode(items: user.allergyList)
                allergyList = "&intolerances=\(allergies)"
            }

            let complexURL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex?addRecipeInformation=true\(dietList)&fillIngredients=false&includeIngredients=\(ingredients)&instructionsRequired=true\(allergyList)&limitLicense=false&number=100&offset=0&ranking=2"

            Alamofire.request(complexURL, method: .get, headers: spoonacularAPIHeaders).responseJSON {
                (response) in
                if let json = response.result.value as? [String: Any] {
                    if let responseJSON = json["results"] as? [[String: Any]] {
                        print("We got the json and its", responseJSON)
                        completion(.success(responseJSON))
                    } else {
                        completion(.failure(.nodata))
                    }
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

class Helper {

    static func spoonacularEncode(items: [String]) -> String {
        var container  = ""
        for item in items {
            let newItem = item.replacingOccurrences(of: " ", with: "%20")
            if newItem == items.first {
                container += newItem
            } else {
                container += "%2C\(newItem)"
            }
        }
        return container
    }
}

