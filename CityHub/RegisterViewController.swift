//
//  RegisterViewController.swift
//  CityHub
//
//  Created by Jack Cook on 2/26/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import SVProgressHUD
import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    private var closeButton: UIButton!
    private var containerView: UIView!
    private var titleLabel: UILabel!
    private var firstNameField: TextField!
    private var lastNameField: TextField!
    private var emailField: TextField!
    private var passwordField: TextField!
    private var zipcodeField: TextField!
    private var anonymousLabel: UILabel!
    private var anonymousSwitch: Switch!
    private var nextButton: RaisedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if containerView == nil {
            containerView = UIView()
            view.addSubview(containerView)
        }
        
        if titleLabel == nil {
            titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFontWeightSemibold)
            titleLabel.text = "Register".localized
            titleLabel.textColor = .black
            containerView.addSubview(titleLabel)
        }
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: 32, y: 0, width: titleLabel.frame.size.width, height: titleLabel.frame.size.height)
        
        if closeButton == nil {
            closeButton = UIButton()
            closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
            closeButton.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            closeButton.setImage(#imageLiteral(resourceName: "Close"), for: .normal)
            view.addSubview(closeButton)
        }
        closeButton.frame = CGRect(x: view.frame.size.width - 32 - 32 - 16 - 8, y: UIApplication.shared.statusBarFrame.size.height + 32 + (titleLabel.frame.size.height - 64) / 2, width: 64, height: 64)
        
        if firstNameField == nil {
            firstNameField = TextField()
            firstNameField.delegate = self
            firstNameField.placeholder = "First name".localized
            firstNameField.returnKeyType = .next
            containerView.addSubview(firstNameField)
        }
        firstNameField.frame = CGRect(x: 32, y: titleLabel.frame.origin.y + titleLabel.frame.size.height + 56, width: containerView.frame.size.width / 2 - 48, height: 32)
        
        if lastNameField == nil {
            lastNameField = TextField()
            lastNameField.delegate = self
            lastNameField.placeholder = "Last name".localized
            lastNameField.returnKeyType = .next
            containerView.addSubview(lastNameField)
        }
        lastNameField.frame = CGRect(x: containerView.frame.size.width / 2 + 16, y: titleLabel.frame.origin.y + titleLabel.frame.size.height + 56, width: containerView.frame.size.width / 2 - 48, height: 32)
        
        if emailField == nil {
            emailField = TextField()
            emailField.autocapitalizationType = .none
            emailField.autocorrectionType = .no
            emailField.delegate = self
            emailField.keyboardType = .emailAddress
            emailField.placeholder = "Enter your email address".localized
            emailField.returnKeyType = .next
            containerView.addSubview(emailField)
        }
        emailField.frame = CGRect(x: 32, y: firstNameField.frame.origin.y + firstNameField.frame.size.height + 40, width: containerView.frame.size.width - 64, height: 32)
        
        if passwordField == nil {
            passwordField = TextField()
            passwordField.delegate = self
            passwordField.isSecureTextEntry = true
            passwordField.placeholder = "Choose a password".localized
            passwordField.returnKeyType = .next
            containerView.addSubview(passwordField)
        }
        passwordField.frame = CGRect(x: 32, y: emailField.frame.origin.y + emailField.frame.size.height + 40, width: containerView.frame.size.width - 64, height: 32)
        
        if zipcodeField == nil {
            zipcodeField = TextField()
            zipcodeField.delegate = self
            zipcodeField.keyboardType = .numberPad
            zipcodeField.placeholder = "Enter your zipcode".localized
            zipcodeField.returnKeyType = .next
            containerView.addSubview(zipcodeField)
        }
        zipcodeField.frame = CGRect(x: 32, y: passwordField.frame.origin.y + passwordField.frame.size.height + 40, width: containerView.frame.size.width - 64, height: 32)
        
        if anonymousLabel == nil {
            anonymousLabel = UILabel()
            anonymousLabel.font = UIFont.systemFont(ofSize: 16)
            anonymousLabel.text = "Appear anonymous?".localized
            anonymousLabel.textColor = .black
            containerView.addSubview(anonymousLabel)
        }
        anonymousLabel.sizeToFit()
        anonymousLabel.frame = CGRect(x: 32, y: zipcodeField.frame.origin.y + zipcodeField.frame.size.height + 32, width: anonymousLabel.frame.size.width, height: anonymousLabel.frame.size.height)
        
        if anonymousSwitch == nil {
            anonymousSwitch = Switch()
            anonymousSwitch.buttonOnColor = Constants.primaryRedColor
            anonymousSwitch.isOn = true
            anonymousSwitch.switchSize = .medium
            anonymousSwitch.trackOnColor = Constants.whiterRedColor
            containerView.addSubview(anonymousSwitch)
        }
        let anonymousSwitchSize = CGSize(width: 64, height: 48)
        anonymousSwitch.frame = CGRect(x: containerView.frame.size.width - 32 - anonymousSwitchSize.width, y: anonymousLabel.frame.origin.y + (anonymousLabel.frame.size.height - anonymousSwitchSize.height) / 2, width: anonymousSwitchSize.width, height: anonymousSwitchSize.height)
        
        if nextButton == nil {
            nextButton = RaisedButton()
            nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
            nextButton.backgroundColor = Constants.primaryRedColor
            nextButton.pulseColor = .white
            nextButton.title = "NEXT".localized
            nextButton.titleColor = .white
            nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
            containerView.addSubview(nextButton)
        }
        nextButton.frame = CGRect(x: containerView.frame.size.width - 32 - 84, y: anonymousSwitch.frame.origin.y + anonymousSwitch.frame.size.height + 28, width: 84, height: 36)
        
        let containerHeight = (self.nextButton.frame.origin.y + self.nextButton.frame.height) - self.titleLabel.frame.origin.y
        self.containerView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.size.height + 32, width: self.view.frame.width, height: containerHeight)
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
        SVProgressHUD.show()
        
        CityHubClient.shared.users.register(firstName: firstNameField.text ?? "", lastName: lastNameField.text ?? "", anonymous: anonymousSwitch.isOn, zipcode: zipcodeField.text ?? "", languages: ["en-US"], email: emailField.text ?? "") { user, error in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            
            guard let _ = user, error == nil else {
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func activeTextField() -> UITextField? {
        if firstNameField.isFirstResponder {
            return firstNameField
        }
        
        if lastNameField.isFirstResponder {
            return lastNameField
        }
        
        if emailField.isFirstResponder {
            return emailField
        }
        
        if passwordField.isFirstResponder {
            return passwordField
        }
        
        if zipcodeField.isFirstResponder {
            return zipcodeField
        }
        
        return nil
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        guard nextButton != nil, let keyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height, let textField = activeTextField() else {
            return
        }
        
        UIView.animate(withDuration: 0.25) {
            let screenHeight = self.view.frame.height - keyboardHeight
            let textFieldY = (screenHeight - textField.frame.height) / 2
            let containerY = textFieldY - textField.frame.origin.y
            
            let containerHeight = (self.nextButton.frame.origin.y + self.nextButton.frame.height) - self.titleLabel.frame.origin.y
            self.containerView.frame = CGRect(x: 0, y: containerY, width: self.view.frame.width, height: containerHeight)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard nextButton != nil else {
            return
        }
        
        UIView.animate(withDuration: 0.25) {
            let containerHeight = (self.nextButton.frame.origin.y + self.nextButton.frame.height) - self.titleLabel.frame.origin.y
            self.containerView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.size.height + 32, width: self.view.frame.width, height: containerHeight)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            let _ = lastNameField.becomeFirstResponder()
        } else if textField == lastNameField {
            let _ = emailField.becomeFirstResponder()
        } else if textField == emailField {
            let _ = passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            let _ = zipcodeField.becomeFirstResponder()
        } else if textField == zipcodeField {
            zipcodeField.resignFirstResponder()
        }
        
        return true
    }
}
