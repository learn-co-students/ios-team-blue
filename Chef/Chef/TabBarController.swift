import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.statusBarStyle = .default
        self.tabBar.tintColor = Style.flatironBlue

        let generateRecipesVC = GenerateRecipesViewController()
        let navViewController = NavigationController(rootViewController: generateRecipesVC)

        self.setViewControllers([navViewController], animated: true)
    }

}
