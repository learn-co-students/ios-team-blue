import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let generateRecipesVC = GenerateRecipesViewController()
        let userSettingsVC = UserSettingsViewController()
        

        let navViewController = UINavigationController(rootViewController: generateRecipesVC)
        let setViewController = UINavigationController(rootViewController: userSettingsVC)

        self.tabBar.barTintColor = Style.flatironBlue
        setViewController.tabBarItem = UITabBarItem(title: "settings", image: #imageLiteral(resourceName: "userIcon"), tag: 4)
        navViewController.tabBarItem = UITabBarItem(title: "recipes", image: UIImage(named: "cookbook"), tag: 1)

        navViewController.navigationBar.barStyle = .blackTranslucent

        self.setViewControllers([navViewController, setViewController], animated: true)
    }

}
