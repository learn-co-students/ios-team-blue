import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager {

    static let usersRef = FIRDatabase.database().reference().child("users")

    static func login(email: String, password: String, completion: @escaping (Bool) -> ()) {
        print("FirebaseManager.\(#function)")

        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print("FirebaseManager.\(#function) -- Could not log in: \(error)")
                completion(false)
            } else if let _ = user {
                print("FirebaseManager.\(#function) -- User \(email) successfully logged in")
                completion(true)
            }
        })
    }

    static func signUp(email: String, password: String, completion: @escaping (Bool) -> ()) {
        print("FirebaseManager.\(#function)")

        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print("FirebaseManager.\(#function) -- Could not sign up: \(error)")
                completion(false)
            } else if let _ = user {
                print("FirebaseManager.\(#function) -- User \(email) successfully signed up")
                completion(true)
            }
        })
    }

    static func signOut(completion: ((Bool) -> ())) {
        print("FirebaseManager.\(#function) -- Attempting signout")
        do {
            try FIRAuth.auth()?.signOut()
            print("FirebaseManager.\(#function) -- User successfully signed out")
            completion(true)
        } catch let signOutError as NSError {
            print("FirebaseManager.\(#function) -- Could not sign out: %@", signOutError)
            completion(false)
        }
    }

    static func addUser(_ user: User) {
        print("FirebaseManager.\(#function) -- Adding user")

        let defaults = ["favRecipes": ["0": "default"], "fridge": ["0": "default"]]
        self.usersRef.child(user.id).setValue(defaults)
    }

    static func deleteUser(completion: @escaping (Bool) -> ()) {
        print("FirebaseManager.\(#function) -- Removing user")

        FIRAuth.auth()?.currentUser?.delete { error in
            if let error = error {
                print("FirebaseManager.\(#function) -- Could not remove user: \(error)")
                completion(false)
            } else {
                print("FirebaseManager.\(#function) -- User successfully deleted")
                completion(true)
            }
        }
    }

    static func deleteUserData(_ user: User) {
        print("FirebaseManager.\(#function) -- Deleting user data")

        self.usersRef.child(user.id).removeValue()
    }

    static func checkIfUserExists(_ user: User, completion: @escaping (Bool) -> ()) {
        print("FirebaseManager.\(#function) -- Checking if user exists")

        self.usersRef.observeSingleEvent(of: .value, with: { snapshot in
            guard let snap = snapshot.value as? JSONDictionary else {
                print("FirebaseManager.\(#function) -- Casting failed")
                return
            }
            let userExists = snap[user.id] == nil ? false : true
            if userExists {
                print("FirebaseManager.\(#function) -- User \(user.email) exists")
            } else {
                print("FirebaseManager.\(#function) -- User \(user.email) does not exist")
            }
            completion(userExists)
        })
    }

    static func getUserData(_ user: User, completion: @escaping ((favRecipeIDs: [String], fridge: [String], diet: [String]?, allergy: [String]?)) -> ()) {
        print("FirebaseManager.\(#function) -- Getting user data")

        usersRef.child(user.id).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snap = snapshot.value as? [String: Any],
                  let favRecipesIDs = snap["favRecipes"] as? [String],
                  let fridge = snap["fridge"] as? [String] else {
                print("FirebaseManager.\(#function) -- Could not get user data")
                return
            }
            if let restrictions = snap["dietaryRestrictions"] as? [String: Any],
                let diet = restrictions["diet"] as? [String]?,
                let allergy = restrictions["allergies"] as? [String]? {
                completion((favRecipesIDs, fridge, diet, allergy))
            } else if let restrictions = snap["dietaryRestrictions"] as? [String: Any],
                let diet = restrictions["diet"] as? [String]?{
                completion((favRecipesIDs, fridge, diet, nil))
            } else if let restrictions = snap["dietaryRestrictions"] as? [String: Any],
                let allergy = restrictions["allergies"] as? [String]? {
                completion((favRecipesIDs, fridge, nil, allergy))
            } else {
                completion((favRecipesIDs, fridge, nil, nil))
            }
            
        })
    }

    static func setFavoriteRecipes(_ dict: JSONDictionary, for user: User) {
        print("FirebaseManager.\(#function) -- Setting favorite recipes")

        usersRef.child(user.id).child("favRecipes").setValue(dict)
    }

    static func addDietaryRestrictions(_ dict: JSONDictionary, to user: User, completion: () -> ()) {
        print("FirebaseManager.\(#function) -- Adding dietary restrictions")

        self.usersRef.child(user.id).child("dietaryRestrictions").child("diet").setValue(dict)
        completion()
    }

    static func addAllergy(_ dict: JSONDictionary, to user: User, completion: () -> ()) {
        print("FirebaseManager.\(#function) -- Adding allergy")

        self.usersRef.child(user.id).child("dietaryRestrictions").child("allergies").setValue(dict)
        completion()
    }

    static func setIngredients(_ dict: JSONDictionary, for user: User, completion: () -> ()) {
        print("FirebaseManager.\(#function) -- Setting ingredients")

        self.usersRef.child(user.id).child("fridge").setValue(dict)
        completion()
    }
    

}
