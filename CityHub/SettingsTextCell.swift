//
//  SettingsTextCell.swift
//  CityHub
//
//  Created by Jack Cook on 3/4/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class SettingsTextCell: UITableViewCell {
    
    private var container: UIView!
    private var label: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        
        if container == nil {
            container = UIView()
            container.backgroundColor = .white
            addSubview(container)
        }
        container.frame = CGRect(x: 12, y: 0, width: bounds.width - 24, height: bounds.height)
        
        if label == nil {
            label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.text = "Testing"
            label.textColor = .black
            addSubview(label)
        }
        label.sizeToFit()
        label.frame = CGRect(x: 24, y: (bounds.height - label.frame.size.height) / 2, width: label.frame.size.width, height: label.frame.size.height)
    }
}
