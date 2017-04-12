//
//  AddDietViewController.swift
//  Chef
//
//  Created by Kaypree Hodges on 4/12/17.
//  Copyright © 2017 Blue Team. All rights reserved.
//

import UIKit

class AddDietViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    func createSettings() {
        let diet = UILabel()
        diet.text = "Dietary Restrictions"
        let intolerances = UILabel()
        intolerances.text = "Dietary Restrictions"
        //Diet possible choices -  pescetarian, lacto vegetarian, ovo vegetarian, vegan, and vegetarian
        //intolerances - dairy, egg, gluten, peanut, sesame, seafood, shellfish, soy, sulfite, tree nut, and wheat

        let pescetarian = UIButton(type: .contactAdd)


    }

}
