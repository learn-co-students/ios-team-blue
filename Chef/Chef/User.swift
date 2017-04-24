import Foundation

class User: CustomStringConvertible {
   
    var email: String
    var favRecipes: [String]
    var fridge: [String]
    var dietList: [String]
    var allergyList: [String]

    var id: String {
        var str = self.email
        str = str.replacingOccurrences(of: "@", with: "")
        str = str.replacingOccurrences(of: ".", with: "")
        return str
    }

    var description: String {
        return "email: \(self.email)\nfavRecipes: \(self.favRecipes)\nfridge: \(fridge)"
    }

    init(email: String) {
        self.email = email
        self.favRecipes = []
        self.fridge = []
        self.dietList = []
        self.allergyList = []
    }

}
