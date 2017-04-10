import Foundation

protocol LoginViewDelegate: class {

    func backgroundTapped()
    func loginSignupButtonTapped()
    func switchButtonTapped()

    // MARK: - Test
    func backgroundDoubleTapped()

}
