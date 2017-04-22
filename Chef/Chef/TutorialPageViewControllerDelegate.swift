import Foundation

protocol TutorialPageViewControllerDelegate: class {

    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController, didUpdatePageCount count: Int)

    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController, didUpdatePageIndex index: Int)
    
}
