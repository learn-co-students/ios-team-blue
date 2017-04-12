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

    static func deleteUserData(_ user: User) {
        self.usersRef.child(user.id).removeValue()
    }

}
