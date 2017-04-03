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


        self.usernameTextField.layer.cornerRadius = 10.0
        self.usernameTextField.layer.shadowColor = UIColor.white.cgColor
        self.usernameTextField.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.usernameTextField.layer.shadowRadius = 5.0
        self.usernameTextField.layer.shadowOpacity = 1.0

        self.usernameTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.66)
        }
    }
    
    func createPasswordField() {
        self.view.addSubview(self.passwordTextField)
        self.passwordTextField.backgroundColor = .white

        self.passwordTextField.layer.cornerRadius = 10.0
        self.passwordTextField.layer.shadowColor = UIColor.white.cgColor
        self.passwordTextField.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.passwordTextField.layer.shadowRadius = 5.0
        self.passwordTextField.layer.shadowOpacity = 1.0
        
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
        self.loginButton.backgroundColor = .white
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.setTitleColor(.black, for: .normal)
        self.loginButton.layer.cornerRadius = 4
        self.loginButton.layer.shadowColor = UIColor.white.cgColor
        self.loginButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.loginButton.layer.shadowRadius = 3.0
        self.loginButton.layer.shadowOpacity = 3.0

        self.view.addSubview(self.loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }



    func loginButtonPressed() {
        guard usernameTextField.text != "", passwordTextField.text != "" else {usernameTextField.shake();
            passwordTextField.shake();
            return}
    }


}

