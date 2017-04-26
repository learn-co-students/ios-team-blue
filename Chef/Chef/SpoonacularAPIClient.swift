import UIKit
import Alamofire
import SwiftyJSON

final class SpoonacularAPIClient {

    private static let baseURL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients="
    private static let otherInfoURL = "&limitLicense=false&number=20&ranking=1"

    static func generateRecipes(for user: User, completion: @escaping (SpoonacularAPIClientResponse) -> ()) {
        print("SpoonacularAPIClient.\(#function)")

        //If the user has no dietary restriction/intolerances
        if user.allergyList.isEmpty && user.dietList.isEmpty {
//            print("Doin the standard call")
            let ingredients = self.spoonacularEncode(items: user.fridge)
            let url = baseURL + ingredients + otherInfoURL
            //print("SpoonacularAPIClient.\(#function) -- \(url)")
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
            let ingredients = self.spoonacularEncode(items: user.fridge)
            var allergyList = ""
            var dietList = ""

            if !user.dietList.isEmpty {
                let diets = self.spoonacularEncode(items: user.dietList)
                dietList = "&diet=\(diets)"
            }
            if !user.allergyList.isEmpty {
                let allergies = self.spoonacularEncode(items: user.allergyList)
                allergyList = "&intolerances=\(allergies)"
            }

            let complexURL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex?addRecipeInformation=true\(dietList)&fillIngredients=false&includeIngredients=\(ingredients)&instructionsRequired=true\(allergyList)&limitLicense=false&number=100&offset=0&ranking=2"

            Alamofire.request(complexURL, method: .get, headers: spoonacularAPIHeaders).responseJSON {
                (response) in
                if let json = response.result.value as? [String: Any] {
                    if let responseJSON = json["results"] as? [[String: Any]] {
//                        print("We got the json and its", responseJSON)
                        completion(.success(responseJSON))
                    } else {
                        completion(.failure(.nodata))
                    }
                }
            }
        }
    }

    static func fetchRecipe(id: String, completion: @escaping (SpoonacularAPIClientResponse) -> ()) {
        print("SpoonacularAPIClient.\(#function)")

        let endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/\(id)/information?includeNutrition=false"
        Alamofire.request(endpoint, method: .get, headers: spoonacularAPIHeaders).responseJSON { response in
            if let json = response.result.value as? JSONDictionary {
                if let recipe = Recipe(dictionary: json) {
                    completion(.success(recipe))
                } else {
                    print(#function + " -- skipped recipe")
                }
            } else {
                completion(.failure(.nodata))
            }
        }
    }

    static func fetchRecipes(ids: [String], completion: @escaping (SpoonacularAPIClientResponse) -> ()) {
        print("SpoonacularAPIClient.\(#function)")

        let endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/informationBulk?ids=\(spoonacularEncode(items: ids))&includeNutrition=false"

        Alamofire.request(endpoint, method: .get, headers: spoonacularAPIHeaders).responseJSON { response in
            var recipes = [Recipe]()
            if let json = response.result.value as? [JSONDictionary] {
                for entry in json {
                    if let recipe = Recipe(dictionary: entry) {
                        recipes.append(recipe)
                    } else {
                        print("SpoonacularAPIClient.\(#function) -- Recipe could not be initialized")
                    }
                }
                completion(.success(recipes))
            } else {
                print("SpoonacularAPIClient.\(#function) -- Failed")
                completion(.failure(.error))
            }
        }
    }

    static func fetchSavedRecipes(ids: [String], completion: @escaping (SpoonacularAPIClientResponse) -> ()) {
        print("SpoonacularAPIClient.\(#function)")

        self.fetchRecipes(ids: ids) { result in
            switch result {
            case .success(let recipes):
                guard let recipes = recipes as? [Recipe] else { return }
                var savedRecipes = [Recipe]()
                for recipe in recipes {     // copy
                    savedRecipes.append(recipe)
                }
                for recipe in savedRecipes {    // favorite each recipe
                    recipe.isFavorite = true
                }
                completion(SpoonacularAPIClientResponse.success(savedRecipes))
            case .failure(let error):
                print(error)
                completion(.failure(.error))
            }
        }
    }

    static func fetchRecipeDetail(id: String, completion: @escaping (SpoonacularAPIClientResponse) -> ()) {
        print("SpoonacularAPIClient.\(#function)")

        let endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/\(id)/information?includeNutrition=false"
        Alamofire.request(endpoint, method: .get, headers: spoonacularAPIHeaders).responseJSON { response in
            guard let recipeDetail = response.result.value as? JSONDictionary else {
                completion(.failure(SpoonacularAPIClientError.nodata))
                return
            }
            completion(.success(recipeDetail))
        }
    }

    static func randomJoke() -> String {
        print("SpoonacularAPIClient.\(#function)")

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

    static func parseIngredients(_ json: [JSONDictionary]) -> [String] {
        var ingredients = [String]()
        for entry in json {
            guard let ingredient = entry["originalString"] as? String else {
                fatalError("SpoonacularAPIClient.\(#function) -- failed")
            }
            ingredients.append(ingredient)
        }

        return ingredients
    }

    static func parseInstructions(_ json: [JSONDictionary]) -> [String] {
        var instructions = [String]()

        guard let instructionsArray = json.first, let steps = instructionsArray["steps"] as? [JSONDictionary] else {
            print("SpoonacularAPIClient.\(#function) -- Error")
            return []
        }

        for step in steps {
            guard let instruction = step["step"] as? String else {
                fatalError()
            }
            instructions.append(instruction)
        }

        return instructions
    }


    // MARK: - Helper

    private static func spoonacularEncode(items: [String]) -> String {
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
