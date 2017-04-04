import Foundation
import Firebase
import FirebaseDatabase

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
                print("\nUser \(user.description) successfully logged in\n")
                addUser()
                completion?(true)
            }
        })
    }

    private static func addUser() {
        let defaults = ["favRecipes": ["0": "default"], "fridge": ["0": "default"]]
        usersRef.childByAutoId().setValue(defaults)
    }

}