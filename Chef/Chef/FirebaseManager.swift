import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager {

    static let usersRef = FIRDatabase.database().reference().child("users")

    static func login(email: String, password: String, completion: @escaping (Bool) -> ()) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print("\nFirebaseManager -- \(#function) -- Could not log in: \(error)\n")
                completion(false)
            } else if let _ = user {
                print("\nFirebaseManager -- \(#function) -- User \(email) successfully logged in\n")
                completion(true)
            }
        })
    }

    static func signUp(email: String, password: String, completion: @escaping (Bool) -> ()) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print("\nFirebaseManager -- \(#function) -- Could not sign up: \(error)\n")
                completion(false)
            } else if let _ = user {
                print("\nFirebaseManager -- \(#function) -- User \(email) successfully signed up\n")
                completion(true)
            }
        })
    }

    static func signOut(completion: ((Bool) -> ())) {
        do {
            try FIRAuth.auth()?.signOut()
            print("\nFirebaseManager -- \(#function) -- User successfully signed out\n")
            completion(true)
        } catch let signOutError as NSError {
            print("\nFirebaseManager -- \(#function) -- Could not sign out: %@\n", signOutError)
            completion(false)
        }
    }

    static func addUser(_ user: User) {
        let defaults = ["favRecipes": ["0": "default"], "fridge": ["0": "default"]]
        self.usersRef.child(user.id).setValue(defaults)
        print("\nFirebaseManager -- \(#function) -- User \(user.email) added\n")
    }

    static func deleteUser(completion: @escaping (Bool) -> ()) {
        FIRAuth.auth()?.currentUser?.delete { error in
            if let error = error {
                print("\nFirebaseManager -- \(#function) -- Could not delete user: \(error)\n")
                completion(false)
            } else {
                print("\nFirebaseManager -- \(#function) -- User successfully deleted\n")
                completion(true)
            }
        }
    }

    static func deleteUserData(_ user: User) {
        self.usersRef.child(user.id).removeValue()
        print("\nFirebaseManager -- \(#function) -- User successfully deleted\n")
    }

    static func checkIfUserExists(_ user: User, completion: @escaping (Bool) -> ()) {
        self.usersRef.observeSingleEvent(of: .value, with: { snapshot in
            guard let snap = snapshot.value as? JSONDictionary else {
                return
            }
            let userExists = snap[user.id] == nil ? false : true
            if userExists {
                print("\nFirebaseManager -- \(#function) -- User \(user.email) exists\n")
            } else {
                print("\nFirebaseManager -- \(#function) -- User \(user.email) does not exist\n")
            }
            completion(userExists)
        })
    }

    static func getUserData(_ user: User, completion: @escaping ((favRecipeIDs: [String], fridge: [String], diet: [String]?, allergy: [String]?)) -> ()) {
        let ref = usersRef.child(user.id)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snap = snapshot.value as? [String: Any],
                let favRecipesIDs = snap["favRecipes"] as? [String],
                let fridge = snap["fridge"] as? [String] else {
                    print(#function + " failed")
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

    static func getUserData(_ user: User, completion: @escaping (([String], [String])) -> ()) {
        usersRef.child(user.id).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snap = snapshot.value as? [String: Any],
                let favRecipesIDs = snap["favRecipes"] as? [String],
                let fridge = snap["fridge"] as? [String] else {
                    print("\nFirebaseManager -- \(#function) -- Could not get user data\n")
                    return
            }
            completion(favRecipesIDs, fridge)
        })
    }

    static func addDietaryRestrictions(_ diet: [String], to user: User) {
        self.usersRef.child(user.id).child("dietaryRestrictions").child("diet").setValue(diet)
        print("\nFirebaseManager -- \(#function) -- Added dietary restrictions\n")
    }

    static func addAllergy(_ allergy: [String], to user: User) {
        self.usersRef.child(user.id).child("dietaryRestrictions").child("allergies").setValue(allergy)
        print("\nFirebaseManager -- \(#function) -- Added allergy\n")
    }

}
