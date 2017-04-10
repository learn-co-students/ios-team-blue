import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let generateRecipesVC = GenerateRecipesViewController()
        let userSettingsVC = UserSettingsViewController()
        

        let navViewController = UINavigationController(rootViewController: generateRecipesVC)
        let setViewController = UINavigationController(rootViewController: userSettingsVC)
<<<<<<< Updated upstream

        self.setViewControllers([navViewController, setViewController], animated: true)

        self.tabBar.barTintColor = Colors.flatironBlue

=======

        self.setViewControllers([navViewController, setViewController], animated: true)
>>>>>>> Stashed changes
    }

}
