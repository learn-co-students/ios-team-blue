import UIKit

class ManualEntryViewController: UIViewController, ManualEntryViewDelegate{
    var manualEntryView: ManualEntryView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.manualEntryView = ManualEntryView()
        self.manualEntryView.delegate = self
        self.view.addSubview(self.manualEntryView)
        self.manualEntryView.snapToSuperview()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func saveFoodButtonTapped() {
        print(#function)
    }
    



}
