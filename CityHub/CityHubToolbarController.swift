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
    
    private var emptyButton: IconButton!
    private var searchButton: IconButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare() {
        super.prepare()
        
        emptyButton = IconButton(image: nil, tintColor: .white)
        emptyButton.pulseColor = .clear
        
        searchButton = IconButton(image: Icon.cm.search, tintColor: .white)
        searchButton.pulseColor = .white
        
        statusBarStyle = .lightContent
        statusBar.backgroundColor = Color.blue.darken3
        
        toolbar.backgroundColor = Color.blue.darken2
        toolbar.leftViews = []
        toolbar.rightViews = [searchButton]
    }
}
