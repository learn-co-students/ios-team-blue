import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager {

    static let usersRef = FIRDatabase.database().reference().child("users")

    static func login(email: String, password: String, completion: ((Bool) -> ())?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error)
                completion?(false)
            } else if let user = user {
                print("\nUser \(user.description) successfully logged in\n")
                completion?(true)
            }
        })
    }

    static func signUp(email: String, password: String, completion: ((Bool) -> ())?) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error)
                completion?(false)
            } else if let user = user {
                print("\nUser \(user.description) successfully signed up\n")
                completion?(true)
            }
        })
    }

    static func addUser(_ user: User) {
        let defaults = ["favRecipes": ["0": "default"], "fridge": ["0": "default"]]
        self.usersRef.child(user.id).setValue(defaults)
    }

    static func signOut() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let signOutError as NSError{
            print("Error signing out: %@", signOutError)
        }
    }

    static func deleteUser() {
        FIRAuth.auth()?.currentUser?.delete(completion: { (error) in
            if error != nil {
                print("Error occurred", error?.localizedDescription as Any)
            } else {
                print("User was deleted")
            }
        })
    }

    static func checkIfUserExists(_ user: User, completion: @escaping (Bool) -> ()) {
        self.usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snap = snapshot.value as? [String: Any] else { return }
            let userExists = snap[user.id] == nil ? false : true
            completion(userExists)
        })
    }

    //TODO: - Update to pull any diet information if it exists.
    static func getUserData(_ user: User, completion: @escaping (([String], [String])) -> ()) {
        let ref = usersRef.child(user.id)

        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snap = snapshot.value as? [String: Any],
                let favRecipesIDs = snap["favRecipes"] as? [String],
                let fridge = snap["fridge"] as? [String] else {
                    print(#function + " failed")
                    return
            }
            completion(favRecipesIDs, fridge)
        })
    }

    static func addDiet(_ diet: [String], to user: User) {
        self.usersRef.child(user.id).child("dietaryRestrictions").child("diet").setValue(diet)
    }

    static func addAllergy(_ allergy: [String], to user: User) {
        self.usersRef.child(user.id).child("dietaryRestrictions").child("allergies").setValue(allergy)
    }
}
