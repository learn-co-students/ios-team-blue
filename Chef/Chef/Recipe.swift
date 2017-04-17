import UIKit

class Recipe {
    var id: String
    var title: String
    var imageLink: String
    var instructions: [String]?
    //TODO: - Breaks if user has no saved recipes in firebase.
    init(dictionary: [String: Any]) {
        guard
        let id =  dictionary["id"] as? Int,
        let title = dictionary["title"] as? String,
        let imageLink = dictionary["image"] as? String else {
            fatalError("Could not create recipe from dictionary. You're going to starve!")
        }

        self.id = String(id)
        self.title = title
        self.imageLink = imageLink
    }

}
