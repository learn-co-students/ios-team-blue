import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let generateRecipesVC = GenerateRecipesViewController()

        let navViewController = UINavigationController(rootViewController: generateRecipesVC)
        navViewController.navigationBar.barStyle = .blackTranslucent

        self.setViewControllers([navViewController], animated: true)
    }

}
