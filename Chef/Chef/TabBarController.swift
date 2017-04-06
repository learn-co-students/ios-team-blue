import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let generateRecipesVC = GenerateRecipesViewController()

        let navViewController = UINavigationController(rootViewController: generateRecipesVC)

        self.setViewControllers([navViewController], animated: true)
    }

}
