//
//  LoginViewController.swift
//  CityHub
//
//  Created by Jack Cook on 2/26/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import SVProgressHUD
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private var closeButton: UIButton!
    private var titleLabel: UILabel!
    private var emailField: TextField!
    private var passwordField: TextField!
    private var forgotPasswordButton: FlatButton!
    private var registerButton: FlatButton!
    private var nextButton: RaisedButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .white
        
        if titleLabel == nil {
            titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFontWeightSemibold)
            titleLabel.text = "Sign in".localized
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
        
        if emailField == nil {
            emailField = TextField()
            emailField.autocapitalizationType = .none
            emailField.autocorrectionType = .no
            emailField.delegate = self
            emailField.keyboardType = .emailAddress
            emailField.placeholder = "Enter your email address".localized
            emailField.returnKeyType = .next
            emailField.spellCheckingType = .no
            view.addSubview(emailField)
        }
        emailField.frame = CGRect(x: 32, y: titleLabel.frame.origin.y + titleLabel.frame.size.height + 56, width: view.frame.size.width - 64, height: 32)
        
        if passwordField == nil {
            passwordField = TextField()
            passwordField.delegate = self
            passwordField.isSecureTextEntry = true
            passwordField.placeholder = "Enter your password".localized
            passwordField.returnKeyType = .done
            view.addSubview(passwordField)
        }
        passwordField.sizeToFit()
        passwordField.frame = CGRect(x: 32, y: emailField.frame.origin.y + emailField.frame.size.height + 40, width: view.frame.size.width - 64, height: 32)
        
        if nextButton == nil {
            nextButton = RaisedButton()
            nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
            nextButton.backgroundColor = Constants.primaryRedColor
            nextButton.pulseColor = .white
            nextButton.title = "NEXT".localized
            nextButton.titleColor = .white
            nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
            view.addSubview(nextButton)
        }
        nextButton.frame = CGRect(x: view.frame.size.width - 32 - 84, y: passwordField.frame.origin.y + passwordField.frame.size.height + 40, width: 84, height: 36)
        
        if forgotPasswordButton == nil {
            forgotPasswordButton = FlatButton()
            forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
            forgotPasswordButton.title = "Forgot password?".localized
            forgotPasswordButton.titleColor = Constants.primaryRedColor
            forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            view.addSubview(forgotPasswordButton)
        }
        
        if registerButton == nil {
            registerButton = FlatButton()
            registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
            registerButton.title = "Create account".localized
            registerButton.titleColor = Constants.primaryRedColor
            registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            view.addSubview(registerButton)
        }
        forgotPasswordButton.sizeToFit()
        registerButton.sizeToFit()
        
        forgotPasswordButton.frame = CGRect(x: 26, y: nextButton.frame.origin.y + (nextButton.frame.size.height - (forgotPasswordButton.frame.size.height + registerButton.frame.size.height + 12)) / 2, width: forgotPasswordButton.frame.size.width + 12, height: forgotPasswordButton.frame.size.height)
        registerButton.frame = CGRect(x: 26, y: forgotPasswordButton.frame.origin.y + forgotPasswordButton.frame.size.height + 12, width: registerButton.frame.size.width + 12, height: registerButton.frame.size.height)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @objc private func closeButtonPressed(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func forgotPasswordButtonPressed(sender: FlatButton) {
        let fpvc = ForgotPasswordViewController()
        present(fpvc, animated: true, completion: nil)
    }
    
    @objc private func registerButtonPressed(sender: FlatButton) {
        let rvc = RegisterViewController()
        present(rvc, animated: true, completion: nil)
    }
    
    @objc private func nextButtonPressed(sender: RaisedButton?) {
        SVProgressHUD.show()
        
        CityHubClient.shared.users.login(email: emailField.text ?? "", password: passwordField.text ?? "") { user, error in
            guard let _ = user, error == nil else {
                DispatchQueue.main.async {
                    SVProgressHUD.showError(withStatus: error?.getUserMessage() ?? "An unknown error occurred".localized)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    SVProgressHUD.dismiss()
                }
                
                return
            }
            
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            let _ = passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            passwordField.resignFirstResponder()
            nextButtonPressed(sender: nil)
        }
        
        return true
    }
}
