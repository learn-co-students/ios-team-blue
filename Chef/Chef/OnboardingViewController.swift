import UIKit

class OnboardingPager : UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let firstVC = UIViewController()
    let secondVC = UIViewController()
    let thirdVC = UIViewController()
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

    override func viewDidLoad() {
        firstVC.view.backgroundColor = UIColor.red
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
        return [self.firstVC, self.secondVC, self.thirdVC]
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


}
