//
//  SettingsHeaderView.swift
//  CityHub
//
//  Created by Jack Cook on 3/4/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class SettingsHeaderView: UIView {
    
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
            label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightSemibold)
            label.text = "PRIVACY"
            label.textColor = UIColor(white: 131/255, alpha: 1)
            addSubview(label)
        }
        label.sizeToFit()
        label.frame = CGRect(x: 24, y: bounds.height - label.frame.size.height - 6, width: label.frame.size.width, height: label.frame.size.height)
    }
}
