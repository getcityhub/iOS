//
//  CreatePostToolbarController.swift
//  CityHub
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import UIKit

class CreatePostToolbarController: ToolbarController {
    
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
        statusBar.backgroundColor = Constants.darkerRedColor
        
        toolbar.backgroundColor = Constants.primaryRedColor
        toolbar.leftViews = [closeButton]
    }
    
    @objc private func closeButtonPressed(sender: IconButton) {
        dismiss(animated: true, completion: nil)
    }
}
