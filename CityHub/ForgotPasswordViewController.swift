//
//  ForgotPasswordViewController.swift
//  CityHub
//
//  Created by Jack Cook on 2/26/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import SVProgressHUD
import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    private var closeButton: UIButton!
    private var titleLabel: UILabel!
    private var emailField: TextField!
    private var nextButton: RaisedButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .white
        
        if titleLabel == nil {
            titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFontWeightSemibold)
            titleLabel.text = "Forgot password".localized
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
            emailField.returnKeyType = .done
            emailField.spellCheckingType = .no
            view.addSubview(emailField)
        }
        emailField.frame = CGRect(x: 32, y: titleLabel.frame.origin.y + titleLabel.frame.size.height + 56, width: view.frame.size.width - 64, height: 32)
        
        if nextButton == nil {
            nextButton = RaisedButton()
            nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
            nextButton.backgroundColor = Color.blue.base
            nextButton.pulseColor = .white
            nextButton.title = "NEXT".localized
            nextButton.titleColor = .white
            nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
            view.addSubview(nextButton)
        }
        nextButton.frame = CGRect(x: view.frame.size.width - 32 - 84, y: emailField.frame.origin.y + emailField.frame.size.height + 40, width: 84, height: 36)
    }
    
    @objc private func closeButtonPressed(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func nextButtonPressed(sender: RaisedButton?) {
        print("forgot password hasn't been implemented yet :D")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            textField.resignFirstResponder()
            nextButtonPressed(sender: nil)
        }
        
        return true
    }
}
