import Foundation
import UIKit

protocol AddDietDelegate {
    func dietButtonTapped(_ button: UIButton)
    func allergyButtonTapped(_ button: UIButton)
    func saveButtonTapped()
}
