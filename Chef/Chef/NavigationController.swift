import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Style.flatironBlue, NSFontAttributeName: UIFont(name: Style.regular, size: 18) as Any]
    }

}
