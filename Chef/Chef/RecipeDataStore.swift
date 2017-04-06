import Foundation
import CoreData

final class RecipeDataStore {

    static let sharedInstance = RecipeDataStore()
    var recipes = [Recipe]()

    private init() {}

    func getRecipes(user: User, _ completion: @escaping () -> ()) {
        SpoonacularAPIClient.generateRecipes(for: user) { (result) in
            switch result {
            case .success(let recipeList):
                guard let recipeList = recipeList as? [[String: Any]] else {
                    return
                }
                self.recipes.removeAll()
                for dictionary in recipeList {
                    let recipe = Recipe(dictionary: dictionary)
                    self.recipes.append(recipe)
                }
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

    func getRecipeLink(recipe: Recipe, _ completion: @escaping (URL) -> ()) {
        SpoonacularAPIClient.generateRecipeByID(for: recipe) { (result) in
            switch result {
            case .success(let url):
                guard let url = url as? URL else {
                    return
                }
                completion(url)
            case .failure(let error):
                print(error)
            }
        }
    }


    // MARK: - Core Data

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Chef")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
