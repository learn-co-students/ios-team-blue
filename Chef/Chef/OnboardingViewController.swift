import UIKit
import SnapKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let coloring = Colors.flatironBlue.cgColor

    let imageView = UIImageView()
    let screenSize = UIScreen.main.bounds
    let firstVC = UIViewController()
    let secondVC = UIViewController()
    let thirdVC = UIViewController()
    let fourthVC = UIViewController()
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

    override func viewDidLoad() {
        setUpImageView()
        setUpFirstViewController()

        secondVC.view.backgroundColor = UIColor.blue
        thirdVC.view.backgroundColor = UIColor.yellow

        dataSource = self

        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.firstVC, self.secondVC, self.thirdVC, self.fourthVC]
    }()

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
             let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }

        return firstViewControllerIndex
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }

        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                return nil
            }
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count

            guard orderedViewControllersCount != nextIndex else {
                return orderedViewControllers.first
            }

            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            return orderedViewControllers[nextIndex]
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }

    func setUpImageView() {
         imageView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
    }

    func setUpFirstViewController() {
        firstVC.view.frame(forAlignmentRect: screenSize)
        firstVC.view.addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "MyCookBook")
    }

    func setUpSecondViewController() {
        secondVC.view.frame(forAlignmentRect: screenSize)
        secondVC.view.addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "SavedRecipes")
    }

    func setUpThirdViewController() {
        thirdVC.view.frame(forAlignmentRect: screenSize)
        thirdVC.view.addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "FridgeVC")
    }

    func setUpFourthViewController() {
        fourthVC.view.frame(forAlignmentRect: screenSize)
        thirdVC.view.addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "UserSettings")
    }




}
