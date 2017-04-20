import Foundation

class User: CustomStringConvertible {
   
    dynamic var email: String = ""
    dynamic var favRecipes = [String]()
    dynamic var fridge = [String]()
    dynamic var dietList = [String]()
    dynamic var allergyList = [String]()

    dynamic var id: String {
        var str = self.email
        str = str.replacingOccurrences(of: "@", with: "")
        str = str.replacingOccurrences(of: ".", with: "")
        return str
    }

    dynamic var description: String {
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
