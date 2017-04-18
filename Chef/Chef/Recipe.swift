import UIKit

class Recipe {
    
    var id: String
    var title: String
    var imageLink: String
    var instructions: [String]?
    var isFavorite: Bool = false

    init(dictionary: [String: Any]) {
        let id = dictionary["id"] as? String ?? ""
        let title = dictionary["title"] as? String ?? ""
        let imageLink = dictionary["image"] as? String ?? ""

        self.id = id
        self.title = title
        self.imageLink = imageLink
    }

}
