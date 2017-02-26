//
//  RegisterViewController.swift
//  CityHub
//
//  Created by Jack Cook on 2/26/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import UIKit

class RegisterViewController: UIViewController {
    
    private var closeButton: UIButton!
    private var titleLabel: UILabel!
    private var firstNameField: TextField!
    private var lastNameField: TextField!
    private var emailField: TextField!
    private var passwordField: TextField!
    private var zipcodeField: TextField!
    private var anonymousLabel: UILabel!
    private var anonymousSwitch: Switch!
    private var nextButton: RaisedButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .white
        
        if titleLabel == nil {
            titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFontWeightSemibold)
            titleLabel.text = "Register"
            titleLabel.textColor = .black
            view.addSubview(titleLabel)
        }
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: 32, y: UIApplication.shared.statusBarFrame.size.height + 32, width: titleLabel.frame.size.width, height: titleLabel.frame.size.height)
        
        if closeButton == nil {
            closeButton = UIButton()
            closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
            closeButton.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            closeButton.setImage(#imageLiteral(resourceName: "Close"), for: .normal)
            view.addSubview(closeButton)
        }
        closeButton.frame = CGRect(x: view.frame.size.width - 32 - 32 - 16 - 8, y: titleLabel.frame.origin.y + (titleLabel.frame.size.height - 64) / 2, width: 64, height: 64)
        
        if firstNameField == nil {
            firstNameField = TextField()
            firstNameField.placeholder = "First name"
            firstNameField.returnKeyType = .next
            view.addSubview(firstNameField)
        }
        firstNameField.frame = CGRect(x: 32, y: titleLabel.frame.origin.y + titleLabel.frame.size.height + 56, width: view.frame.size.width / 2 - 48, height: 32)
        
        if lastNameField == nil {
            lastNameField = TextField()
            lastNameField.placeholder = "Last name"
            lastNameField.returnKeyType = .next
            view.addSubview(lastNameField)
        }
        lastNameField.frame = CGRect(x: view.frame.size.width / 2 + 16, y: titleLabel.frame.origin.y + titleLabel.frame.size.height + 56, width: view.frame.size.width / 2 - 48, height: 32)
        
        if emailField == nil {
            emailField = TextField()
            emailField.autocapitalizationType = .none
            emailField.autocorrectionType = .no
            emailField.keyboardType = .emailAddress
            emailField.placeholder = "Enter your email address"
            emailField.returnKeyType = .next
            view.addSubview(emailField)
        }
        emailField.frame = CGRect(x: 32, y: firstNameField.frame.origin.y + firstNameField.frame.size.height + 40, width: view.frame.size.width - 64, height: 32)
        
        if passwordField == nil {
            passwordField = TextField()
            passwordField.isSecureTextEntry = true
            passwordField.placeholder = "Choose a password"
            passwordField.returnKeyType = .next
            view.addSubview(passwordField)
        }
        passwordField.frame = CGRect(x: 32, y: emailField.frame.origin.y + emailField.frame.size.height + 40, width: view.frame.size.width - 64, height: 32)
        
        if zipcodeField == nil {
            zipcodeField = TextField()
            zipcodeField.keyboardType = .numberPad
            zipcodeField.placeholder = "Enter your zipcode"
            zipcodeField.returnKeyType = .next
            view.addSubview(zipcodeField)
        }
        zipcodeField.frame = CGRect(x: 32, y: passwordField.frame.origin.y + passwordField.frame.size.height + 40, width: view.frame.size.width - 64, height: 32)
        
        if anonymousLabel == nil {
            anonymousLabel = UILabel()
            anonymousLabel.font = UIFont.systemFont(ofSize: 16)
            anonymousLabel.text = "Appear anonymous?"
            anonymousLabel.textColor = .black
            view.addSubview(anonymousLabel)
        }
        anonymousLabel.sizeToFit()
        anonymousLabel.frame = CGRect(x: 32, y: zipcodeField.frame.origin.y + zipcodeField.frame.size.height + 32, width: anonymousLabel.frame.size.width, height: anonymousLabel.frame.size.height)
        
        if anonymousSwitch == nil {
            anonymousSwitch = Switch()
            anonymousSwitch.isOn = true
            anonymousSwitch.switchSize = .medium
            view.addSubview(anonymousSwitch)
        }
        let anonymousSwitchSize = CGSize(width: 64, height: 48)
        anonymousSwitch.frame = CGRect(x: view.frame.size.width - 32 - anonymousSwitchSize.width, y: anonymousLabel.frame.origin.y + (anonymousLabel.frame.size.height - anonymousSwitchSize.height) / 2, width: anonymousSwitchSize.width, height: anonymousSwitchSize.height)
        
        if nextButton == nil {
            nextButton = RaisedButton()
            nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
            nextButton.backgroundColor = Color.blue.base
            nextButton.pulseColor = .white
            nextButton.title = "NEXT"
            nextButton.titleColor = .white
            nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
            view.addSubview(nextButton)
        }
        nextButton.frame = CGRect(x: view.frame.size.width - 32 - 84, y: anonymousSwitch.frame.origin.y + anonymousSwitch.frame.size.height + 28, width: 84, height: 36)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        zipcodeField.resignFirstResponder()
    }
    
    @objc private func closeButtonPressed(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func nextButtonPressed(sender: UIButton) {
        print("hi")
    }
}