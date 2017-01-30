//
//  PostCard.swift
//  CityHub
//
//  Created by Jack Cook on 30/01/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class PostCard: UIView {
    
    // MARK: Properties
    
    @IBOutlet weak var textView: UITextView!
    
    // MARK: View Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        textView.backgroundColor = UIColor.clear
        
        layer.cornerRadius = 2
        
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.35
        layer.shadowRadius = 2
        layer.shadowPath = shadowPath.cgPath
    }
    
    // MARK: Public Methods
    
    func configure(text: String) {
        textView.text = text
    }
}
