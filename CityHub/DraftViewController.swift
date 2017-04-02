//
//  DraftViewController.swift
//  CityHub
//
//  Created by Jack Cook on 4/2/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class DraftViewController: UIViewController, UITextViewDelegate, PoliticianAutofillViewDelegate {
    
    private var toField: UITextField!
    private var toDownButton: UIButton!
    private var autofillTopBorder: CAShapeLayer!
    private var autofillView: PoliticianAutofillView!
    private var autofillBottomBorder: CAShapeLayer!
    private var messageView: UITextView!
    private var messageViewPlaceholder: UILabel!
    
    private var toDownPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if toField == nil {
            toField = UITextField()
            toField.font = UIFont.systemFont(ofSize: 15)
            toField.placeholder = "To"
            view.addSubview(toField)
        }
        toField.sizeToFit()
        toField.frame = CGRect(x: 16, y: 8, width: view.frame.size.width - 32, height: toField.frame.size.height + 16)
        
        if toDownButton == nil {
            toDownButton = UIButton()
            toDownButton.addTarget(self, action: #selector(toDownButtonPressed), for: .touchUpInside)
            toDownButton.setImage(#imageLiteral(resourceName: "Down"), for: .normal)
            view.addSubview(toDownButton)
        }
        toDownButton.frame = CGRect(x: view.frame.size.width - 16 - toField.frame.size.height, y: 8, width: toField.frame.size.height, height: toField.frame.size.height)
        
        if autofillTopBorder == nil {
            autofillTopBorder = CAShapeLayer()
            autofillTopBorder.backgroundColor = UIColor(white: 0, alpha: 0.1).cgColor
            view.layer.addSublayer(autofillTopBorder)
        }
        autofillTopBorder.frame = CGRect(x: 0, y: toField.frame.origin.y + toField.frame.size.height + 8, width: view.frame.size.width, height: 1)
        
        if autofillView == nil {
            autofillView = PoliticianAutofillView(delegate: self)
            view.addSubview(autofillView)
        }
        autofillView.frame = CGRect(x: 0, y: autofillTopBorder.frame.origin.y + autofillTopBorder.frame.size.height, width: view.frame.size.width, height: toDownPressed ? 256 : 0)
        
        if autofillBottomBorder == nil {
            autofillBottomBorder = CAShapeLayer()
            autofillBottomBorder.backgroundColor = UIColor(white: 0, alpha: 0.1).cgColor
            view.layer.addSublayer(autofillBottomBorder)
        }
        autofillBottomBorder.frame = CGRect(x: 0, y: autofillView.frame.origin.y + autofillView.frame.size.height, width: view.frame.size.width, height: toDownPressed ? 1 : 0)
        
        if messageView == nil {
            messageView = UITextView()
            messageView.delegate = self
            messageView.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)
            view.addSubview(messageView)
        }
        messageView.frame = CGRect(x: 12, y: autofillBottomBorder.frame.origin.y + autofillBottomBorder.frame.size.height + 8, width: view.frame.size.width - 24, height: view.frame.size.height - autofillBottomBorder.frame.origin.y - autofillBottomBorder.frame.size.height - 16)
        
        if messageViewPlaceholder == nil {
            messageViewPlaceholder = UILabel()
            messageViewPlaceholder.font = messageView.font
            messageViewPlaceholder.text = "Say something"
            messageViewPlaceholder.textColor = UIColor(white: 0.5, alpha: 1)
            view.addSubview(messageViewPlaceholder)
        }
        messageViewPlaceholder.sizeToFit()
        messageViewPlaceholder.frame = CGRect(x: 17, y: messageView.frame.origin.y + 8, width: messageViewPlaceholder.frame.size.width, height: messageViewPlaceholder.frame.size.height)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        messageViewPlaceholder.isHidden = messageView.hasText
    }
    
    @objc private func toDownButtonPressed(sender: UIButton) {
        toDownPressed = !toDownPressed
        
        toDownButton.motion(.rotationAngle(toDownPressed ? 180 : 0))
        
        view.setNeedsLayout()
        
        UIView.animate(withDuration: 0.25) { 
            self.view.layoutIfNeeded()
        }
    }
    
    func selectedPolitician(_ politician: Politician) {
        toField.text = politician.name
    }
}
