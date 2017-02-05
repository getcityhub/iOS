//
//  PostCreationToolbar.swift
//  CityHub
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import UIKit

class PostCreationToolbar: UIView {
    
    var delegate: PostCreationToolbarDelegate?
    
    private var topBorder: CALayer!
    private var hashtagLabel: UILabel!
    private var topicButton: UIButton!
    private var postButton: RaisedButton!
    
    init() {
        super.init(frame: CGRect.zero)
        
        layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if topBorder == nil {
            topBorder = CALayer()
            topBorder.backgroundColor = UIColor(white: 0.75, alpha: 1).cgColor
            layer.addSublayer(topBorder)
        }
        topBorder.frame = CGRect(x: 0, y: -1, width: bounds.width, height: 1)
        
        if hashtagLabel == nil {
            hashtagLabel = UILabel()
            hashtagLabel.font = UIFont.systemFont(ofSize: 18)
            hashtagLabel.text = "#"
            hashtagLabel.textColor = UIColor(white: 0.5, alpha: 1)
            addSubview(hashtagLabel)
        }
        hashtagLabel.sizeToFit()
        hashtagLabel.frame = CGRect(x: 16, y: (bounds.height - hashtagLabel.bounds.height) / 2, width: hashtagLabel.bounds.width, height: hashtagLabel.bounds.height)
        
        if postButton == nil {
            postButton = RaisedButton(title: "Post", titleColor: .white)
            postButton.pulseColor = .white
            postButton.backgroundColor = Color.blue.base
            addSubview(postButton)
        }
        postButton.sizeToFit()
        postButton.frame = CGRect(x: bounds.width - postButton.bounds.width - 32 - 16, y: 11, width: postButton.bounds.width + 32, height: bounds.height - 22)
        
        if topicButton == nil {
            topicButton = UIButton(type: .system)
            topicButton.addTarget(self, action: #selector(topicButtonPressed), for: .touchUpInside)
            topicButton.contentHorizontalAlignment = .left
            topicButton.setTitle("Select a topic...", for: .normal)
            topicButton.setTitleColor(UIColor(white: 0.5, alpha: 1), for: .normal)
            topicButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            addSubview(topicButton)
        }
        topicButton.frame = CGRect(x: hashtagLabel.frame.origin.x + hashtagLabel.bounds.width + 8, y: 0, width: postButton.frame.origin.x - 16 - hashtagLabel.frame.origin.x - hashtagLabel.bounds.width - 8, height: bounds.height)
    }
    
    func updateTopic(topic: String?) {
        topicButton.setTitle(topic ?? "Select a topic...", for: .normal)
        topicButton.setTitleColor(UIColor(white: topic == nil ? 0.5 : 0.25, alpha: 1), for: .normal)
    }
    
    @objc private func topicButtonPressed(sender: UIButton) {
        delegate?.topicButtonPressed()
    }
}

protocol PostCreationToolbarDelegate {
    func topicButtonPressed()
}
