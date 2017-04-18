import UIKit
import SnapKit

class ScannedReceiptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var urlToLastPhoto: URL! = {
        return DropDownViewController.getDocumentsDirectory()
    }()
    var tableView: UITableView!



    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    // MARK: - Delegate

    // MARK: - UI

    func createUI() {

        self.tableView = {
            let tv = UITableView(frame: self.view.frame)
            tv.dataSource = self
            tv.delegate = self
            tv.layer.borderColor = Style.flatironBlue.cgColor
            return cv
        }()

        self.view.addSubview(self.tableView)
    }




    
}
