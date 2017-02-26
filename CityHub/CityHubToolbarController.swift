//
//  CityHubToolbarController.swift
//  CityHub
//
//  Created by Jack Cook on 01/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import UIKit

class CityHubToolbarController: ToolbarController {
    
    private var settingsButton: IconButton!
    private var searchButton: IconButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare() {
        super.prepare()
        
        settingsButton = IconButton(image: #imageLiteral(resourceName: "Settings").withRenderingMode(.alwaysTemplate), tintColor: .white)
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        settingsButton.pulseColor = .white
        
        searchButton = IconButton(image: #imageLiteral(resourceName: "Search").withRenderingMode(.alwaysTemplate), tintColor: .white)
        searchButton.pulseColor = .white
        
        statusBarStyle = .lightContent
        statusBar.backgroundColor = Color.blue.darken3
        
        toolbar.backgroundColor = Color.blue.darken2
        toolbar.rightViews = [settingsButton, searchButton]
    }
    
    @objc private func settingsButtonPressed(sender: IconButton) {
        let lvc = LoginViewController()
        present(lvc, animated: true, completion: nil)
    }
}
