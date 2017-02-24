//
//  CreatePostViewController.swift
//  CityHub
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import SVProgressHUD
import UIKit

class CreatePostViewController: UIViewController, UITextViewDelegate, PostCreationToolbarDelegate {
    
    private var textView: UITextView!
    private var textViewPlaceholder: UILabel!
    private var toolbar: PostCreationToolbar!
    
    private var keyboardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView = UITextView()
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        view.addSubview(textView)
        
        textViewPlaceholder = UILabel()
        textViewPlaceholder.font = textView.font
        textViewPlaceholder.text = "What's up?".localized
        textViewPlaceholder.textColor = UIColor(white: 0.5, alpha: 1)
        view.addSubview(textViewPlaceholder)
        
        toolbar = PostCreationToolbar()
        toolbar.delegate = self
        view.addSubview(toolbar)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textViewPlaceholder.sizeToFit()
        textViewPlaceholder.frame = CGRect(x: 21, y: 24, width: textViewPlaceholder.bounds.width, height: textViewPlaceholder.bounds.height)
        
        toolbar.frame = CGRect(x: 0, y: view.bounds.height - 56 - keyboardHeight, width: view.bounds.width, height: 56)
        textView.frame = CGRect(x: 16, y: 16, width: view.bounds.width - 32, height: toolbar.frame.origin.y - 32)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        updateKeyboardAppearance(notification, presenting: true)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        updateKeyboardAppearance(notification, presenting: false)
    }
    
    private func updateKeyboardAppearance(_ notification: Notification, presenting: Bool) {
        guard let userInfo = (notification as NSNotification).userInfo else {
            return
        }
        
        let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboard = view.convert(endFrame, from: view.window)
        
        if keyboard.origin.y + keyboard.size.height > view.bounds.height {
            keyboardHeight = presenting ? view.bounds.height - keyboard.origin.y : 0
        } else {
            keyboardHeight = presenting ? keyboard.height : 0
        }
        
        view.setNeedsLayout()
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textViewPlaceholder.isHidden = textView.hasText
    }
    
    func topicButtonPressed() {
        let stvc = SelectTopicViewController { topic in
            self.toolbar.updateTopic(topic: topic)
        }
        
        let container = SelectTopicToolbarController(rootViewController: stvc)
        present(container, animated: true, completion: nil)
    }
    
    func postButtonPressed() {
        SVProgressHUD.show()
        
        CityHubClient.shared.posts.createPost(authorId: 1, title: "Testing", categoryId: 1, language: "en-US", text: textView.text) { (post, error) in
            guard error == nil else {
                SVProgressHUD.showError(withStatus: "Post failed")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    SVProgressHUD.dismiss()
                }
                
                return
            }
            
            SVProgressHUD.dismiss()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
