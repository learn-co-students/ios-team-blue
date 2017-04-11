import Foundation

struct User: CustomStringConvertible {
   
    var email: String
    var favRecipes: [Int]
    var fridge: [String]

    var description: String {
        return "email: \(self.email)\nfavRecipes: \(self.favRecipes)\nfridge: \(fridge)"
    }

    init() {
        self.email = ""
        self.favRecipes = []
        self.fridge = []
    }

    init(email: String) {
        self.email = email
        self.favRecipes = []
        self.fridge = []
    }

}
