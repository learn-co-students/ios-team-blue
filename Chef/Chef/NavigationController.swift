import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Colors.flatironBlue, NSFontAttributeName: Fonts.medium18]
    }

}
