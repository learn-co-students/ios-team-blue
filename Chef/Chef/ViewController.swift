//
//  ViewController.swift
//  Chef
//
//  Created by Carlos Hernandez on 4/3/17.
//  Copyright © 2017 Blue Team. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
        var usernameTextField = UITextField()
        var passwordTextField = UITextField()
        var loginButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = .white
        createBackgroundImage()
        createUsernameTextField()
        createPasswordField()
        createButton()
    }
    
    
    func createUsernameTextField() {
        self.view.addSubview(self.usernameTextField)
        usernameTextField.backgroundColor = .white
        self.usernameTextField.layer.shadowColor = UIColor.lightGray.cgColor
        self.usernameTextField.layer.shadowOpacity = 2
        self.usernameTextField.layer.shadowRadius = 5
        self.usernameTextField.layer.shadowOffset = CGSize.zero
        
        self.usernameTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.66)
        }
    }
    
    func createPasswordField() {
        self.view.addSubview(self.passwordTextField)
        passwordTextField.backgroundColor = .white
        
        self.passwordTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.usernameTextField.snp.bottom).offset(20)
        }
    }
    
    func createBackgroundImage() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "food-background")
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.left.height.width.equalToSuperview()
        }
        self.view.backgroundColor = .white
    }
    
    func createButton() {
        
        loginButton.backgroundColor = .white
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        
        self.view.addSubview(self.loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }

    func loginButtonPressed() {
        
    }


}

