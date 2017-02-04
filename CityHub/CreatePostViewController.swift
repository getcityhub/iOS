//
//  CreatePostViewController.swift
//  CityHub
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController, UITextViewDelegate {
    
    private var textView: UITextView!
    private var textViewPlaceholder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView = UITextView()
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        view.addSubview(textView)
        
        textViewPlaceholder = UILabel()
        textViewPlaceholder.font = textView.font
        textViewPlaceholder.text = "What's up?"
        textViewPlaceholder.textColor = UIColor(white: 0.5, alpha: 1)
        view.addSubview(textViewPlaceholder)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textViewPlaceholder.sizeToFit()
        textViewPlaceholder.frame = CGRect(x: 21, y: 24, width: textViewPlaceholder.bounds.width, height: textViewPlaceholder.bounds.height)
        
        textView.frame = CGRect(x: 16, y: 16, width: view.bounds.width - 32, height: 256)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let stvc = CreatePostToolbarController(rootViewController: SelectTopicViewController())
        present(stvc, animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textViewPlaceholder.isHidden = textView.hasText
    }
}
