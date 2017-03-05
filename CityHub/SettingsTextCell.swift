//
//  SettingsTextCell.swift
//  CityHub
//
//  Created by Jack Cook on 3/4/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class SettingsTextCell: SettingsCell {
    
    private var label: UILabel!
    private var secondaryLabel: UILabel!
    
    private var primaryText = ""
    private var secondaryText = ""
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        
        if label == nil {
            label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.text = primaryText
            label.textColor = .black
            container.addSubview(label)
        }
        label.sizeToFit()
        label.frame = CGRect(x: 12, y: (container.frame.size.height - label.frame.size.height) / 2, width: label.frame.size.width, height: label.frame.size.height)
        
        if secondaryLabel == nil {
            secondaryLabel = UILabel()
            secondaryLabel.font = UIFont.systemFont(ofSize: 14)
            secondaryLabel.text = secondaryText
            secondaryLabel.textColor = UIColor(white: 131/255, alpha: 1)
            container.addSubview(secondaryLabel)
        }
        secondaryLabel.sizeToFit()
        secondaryLabel.frame = CGRect(x: container.frame.size.width - secondaryLabel.frame.size.width - 12, y: (container.frame.size.height - secondaryLabel.frame.size.height) / 2, width: secondaryLabel.frame.size.width, height: secondaryLabel.frame.size.height)
    }
    
    func configure(_ primaryText: String, _ secondaryText: String) {
        self.primaryText = primaryText
        self.secondaryText = secondaryText
    }
}
