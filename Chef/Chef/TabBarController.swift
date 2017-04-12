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
        savedRecipesVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(named: "cookbook"), tag: 2)
        let srNavVC = NavigationController(rootViewController: savedRecipesVC)

        let navViewControllers = [gNavVC, srNavVC]

        self.setViewControllers(navViewControllers, animated: true)
    }

}
