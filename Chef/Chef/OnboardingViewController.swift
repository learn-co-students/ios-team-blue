import UIKit
import SnapKit
import CHIPageControl

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {


    let screenSize = UIScreen.main.bounds
    let firstVC = UIViewController()
    let secondVC = UIViewController()
    let thirdVC = UIViewController()
    let fourthVC = UIViewController()
    let pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)



    override func viewDidLoad() {
        setUpFirstViewController()
        setUpSecondViewController()
        setUpThirdViewController()
        setUpFourthViewController()
        //setUpPageControllerProgress()

        dataSource = self
        delegate = self

        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        setUpPageControllerProgress()

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


    func setUpFirstViewController() {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        firstVC.view.frame(forAlignmentRect: screenSize)
        firstVC.view.addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "MyCookBook")
    }

    func setUpSecondViewController() {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        secondVC.view.frame(forAlignmentRect: screenSize)
        secondVC.view.addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "SavedRecipes")
    }

    func setUpThirdViewController() {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        thirdVC.view.frame(forAlignmentRect: screenSize)
        thirdVC.view.addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "FridgeVC")
    }

    func setUpFourthViewController() {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        fourthVC.view.frame(forAlignmentRect: screenSize)
        fourthVC.view.addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "UserSettings")
    }

    func setUpPageControllerProgress() {
        let pageControllerDots = CHIPageControlPaprika(frame: CGRect(x: 0, y:0, width: 100, height: 20))
//        pageControllerDots.snp.makeConstraints { (make) in
//            make.center.equalTo(self.view.snp.center)
//        }
        pageControllerDots.numberOfPages = 4
        pageControllerDots.radius = 7
        pageControllerDots.tintColor = .red
        pageControllerDots.currentPageTintColor = .red
        pageControllerDots.padding = 6
//        pageControllerDots.progress = 0.5
        pageControllerDots.set(progress: 5, animated: true)
        self.view.addSubview(pageControllerDots)
        pageControllerDots.layer.position.y = self.view.frame.height-50
        pageControllerDots.layer.position.x = self.view.frame.width-183
    }




}
