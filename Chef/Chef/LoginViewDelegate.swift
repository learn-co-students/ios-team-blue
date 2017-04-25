import Foundation

protocol LoginViewDelegate: class {

    func backgroundTapped()
    func loginSignupButtonTapped()
    func switchButtonTapped()

    // MARK: - For testing
//    func backgroundDoubleTapped()

}
