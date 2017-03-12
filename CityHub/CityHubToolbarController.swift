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
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        searchButton.pulseColor = .white
        
        statusBar.backgroundColor = Constants.darkerRedColor
        
        toolbar.backgroundColor = Constants.primaryRedColor
        toolbar.rightViews = [settingsButton, searchButton]
    }
    
    @objc private func settingsButtonPressed(sender: IconButton) {
        let svc = SettingsViewController()
        let stc = SettingsToolbarController(rootViewController: svc)
        present(stc, animated: true, completion: nil)
    }
    
    @objc private func searchButtonPressed(sender: IconButton) {
        let svc = SearchViewController()
        let stc = SearchToolbarController(rootViewController: svc)
        present(stc, animated: true, completion: nil)
    }
}
