//
//  SettingsToolbarController.swift
//  CityHub
//
//  Created by Jack Cook on 3/4/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import UIKit

class SettingsToolbarController: ToolbarController {
    
    private var closeButton: IconButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare() {
        super.prepare()
        
        closeButton = IconButton(image: #imageLiteral(resourceName: "Close").withRenderingMode(.alwaysTemplate), tintColor: .white)
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        closeButton.pulseColor = .white
        
        statusBarStyle = .lightContent
        statusBar.backgroundColor = Color.blue.darken3
        
        toolbar.backgroundColor = Color.blue.darken2
        toolbar.leftViews = [closeButton]
        toolbar.title = "Settings".localized
        toolbar.titleLabel.textAlignment = .left
        toolbar.titleLabel.textColor = .white
    }
    
    @objc private func closeButtonPressed(sender: IconButton) {
        dismiss(animated: true, completion: nil)
    }
}
