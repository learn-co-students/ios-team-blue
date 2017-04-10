//
//  UserSettingsViewController.swift
//  Chef
//
//  Created by Kaypree Hodges on 4/7/17.
//  Copyright © 2017 Blue Team. All rights reserved.
//

import UIKit
import SnapKit

class UserSettingsViewController: UIViewController {

    var diet: UILabel!
    var logOut: UILabel!
    var resetData: UILabel!
    var deleteAcct: UILabel!
    var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        stackView = UIStackView()
        self.view.addSubview(stackView)
        self.view.backgroundColor = .white
        setupStack()
        setupLabels()
        tabBarItem = UITabBarItem(title: "settings", image: #imageLiteral(resourceName: "userIcon"), tag: 4)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupStack() {
        diet = UILabel()
        logOut = UILabel()
        resetData = UILabel()
        deleteAcct = UILabel()
        stackView.addArrangedSubview(diet)
        stackView.addArrangedSubview(logOut)
        stackView.addArrangedSubview(resetData)
        stackView.addArrangedSubview(deleteAcct)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.equalTo(view)
        }
    }

    func setupLabels() {
        diet.text = "Add Dietary Restrictions"
        diet.textColor = .black
        logOut.text = "Log Out"
        logOut.textColor = .black
        resetData.text = "Reset Data"
        resetData.textColor = .black
        deleteAcct.text = "Delete Account"
        deleteAcct.textColor = .black
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */




}




