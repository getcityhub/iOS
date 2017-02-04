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
    
    private var searchButton: IconButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare() {
        super.prepare()
        
        searchButton = IconButton(image: #imageLiteral(resourceName: "Search").withRenderingMode(.alwaysTemplate), tintColor: .white)
        searchButton.pulseColor = .white
        
        statusBarStyle = .lightContent
        statusBar.backgroundColor = Color.blue.darken3
        
        toolbar.backgroundColor = Color.blue.darken2
        toolbar.rightViews = [searchButton]
    }
}
