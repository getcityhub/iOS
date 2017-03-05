//
//  SettingsCell.swift
//  CityHub
//
//  Created by Jack Cook on 3/4/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    var container: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        selectedBackgroundView = UIView()
        
        if container == nil {
            container = UIView()
            container.backgroundColor = .white
            addSubview(container)
        }
        container.frame = CGRect(x: 12, y: 0, width: bounds.width - 24, height: bounds.height)
    }
}
