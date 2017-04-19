import Foundation


class Recipe: CustomStringConvertible {
    
    let id: String
    let title: String
    let imageLink: String
    var isFavorite: Bool = false
    var servings: Int = 0
    var cookTime: Int = 0
    var ingredients: [String] = []
    var instructions: [String] = []

    var description: String {
        return "\nid: \(id)\ntitle: \(title)\nimageLink: \(imageLink)\nisFavorite: \(isFavorite)\nservings: \(servings)\ncookTime: \(cookTime)\ningredients: \(ingredients)\ninstructions: \(instructions)"
    }

    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
              let title = dictionary["title"] as? String,
              !title.isEmpty,
              let imageLink = dictionary["image"] as? String else {
            return nil
        }

        self.id = String(id)
        self.title = title
        self.imageLink = imageLink
    }

    func addDetail(dictionary dict: JSONDictionary) {
        let servings = dict["servings"] as? Int ?? -1
        let cookTime = dict["readyInMinutes"] as? Int ?? -1
        let ingredientsDict = dict["extendedIngredients"] as? [JSONDictionary] ?? []
        let instructionsDict = dict["analyzedInstructions"] as? [JSONDictionary] ?? []

        self.servings = servings
        self.cookTime = cookTime
        self.ingredients = SpoonacularAPIClient.parseIngredients(ingredientsDict)
        self.instructions = SpoonacularAPIClient.parseInstructions(instructionsDict)
    }

}
