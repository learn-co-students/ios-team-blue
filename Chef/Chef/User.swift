import Foundation

struct User: CustomStringConvertible {
   
    var name: String
    var favRecipes: [Int]
    var fridge: [String]

    var description: String {
        return "name: \(self.name)\nfavRecipes: \(self.favRecipes)\nfridge: \(fridge)"
    }
    
}
