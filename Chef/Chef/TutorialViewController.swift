import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!

    var tutorialPageViewController: TutorialPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.backgroundColor = Colors.flatironBlue



        pageControl.addTarget(self, action: #selector(TutorialViewController.didChangePageControlValue), for: .valueChanged)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
    }

    @IBAction func didTapDoneButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func didChangePageControlValue() {
        tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension TutorialViewController: TutorialPageViewControllerDelegate {

    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }

    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
