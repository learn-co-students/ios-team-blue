import Foundation

class FullRecipe {

    let title: String
    let servings: String
    let prepMinutes: String
    let cookingMinutes: String
    let spoonacularScore: String
    let healthScore: String
    let instructions: String

    init(dictionary dict: JSONDictionary) {
        self.title = dict["title"] as? String ?? ""
        self.servings = dict["servings"] as? String ?? ""
        self.prepMinutes = dict["preparationMinutes"] as? String ?? ""
        self.cookingMinutes = dict["cookingMinutes"] as? String ?? ""
        self.spoonacularScore = dict["spoonacularScore"] as? String ?? ""
        self.healthScore = dict["healthScore"] as? String ?? ""
        self.instructions = dict["instructions"] as? String ?? ""
    }
    
}
