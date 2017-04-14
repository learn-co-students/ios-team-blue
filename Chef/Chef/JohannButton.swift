//
//  JohannButton.swift
//  Chef
//
//  Created by Kaypree Hodges on 4/13/17.
//  Copyright © 2017 Blue Team. All rights reserved.
//

import Foundation
import UIKit


class CustomButton: UIButton {
    var title: String!
    var wasChecked = false

    convenience init(with title: String) {
        self.init()
        self.title = title
    }


}
