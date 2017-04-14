import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.statusBarStyle = .default
        self.tabBar.tintColor = Style.flatironBlue

        let generateRecipesVC = GenerateRecipesViewController()
        generateRecipesVC.tabBarItem = UITabBarItem(title: "Generate", image: UIImage(named: "cookbook"), tag: 1)
        let gNavVC = NavigationController(rootViewController: generateRecipesVC)

        let savedRecipesVC = SavedRecipesViewController()
        savedRecipesVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(named: "heart"), tag: 2)
        let srNavVC = NavigationController(rootViewController: savedRecipesVC)

        let fridgeVC = FridgeViewController()
        fridgeVC.tabBarItem = UITabBarItem(title: "Fridge", image: UIImage(named: "heart"), tag: 3)
        let frNavVC = NavigationController(rootViewController: fridgeVC)

        let userSettingsVC = UserSettingsViewController()
        userSettingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "userIcon"), tag: 4)
        let usNavVC = NavigationController(rootViewController: userSettingsVC)

        let navViewControllers = [gNavVC, srNavVC, frNavVC, usNavVC]

        self.setViewControllers(navViewControllers, animated: true)
    }
    
}
