import Foundation

struct Dish {
    var id: String
    var title: String
    var image: String
    //var link: String? = ""

    init(dictionary: [String: Any]) {
        guard
        let id =  dictionary["id"] as? Int,
        let title = dictionary["title"] as? String,
        let image = dictionary["image"] as? String else {fatalError("Could not create dish from dictionary. You're going to starve!")}
        self.id = String(id)
        self.title = title
        self.image = image
    }

}
