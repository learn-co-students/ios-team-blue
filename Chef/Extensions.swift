//
//  Extensions.swift
//  Chef
//
//  Created by Sejan Miah on 4/3/17.
//  Copyright © 2017 Blue Team. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension UITextField {


    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }

}
