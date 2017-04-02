//
//  DraftToolbarController.swift
//  CityHub
//
//  Created by Jack Cook on 4/2/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import UIKit

class DraftToolbarController: ToolbarController {
    
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
        toolbar.title = "Draft your message"
        toolbar.titleLabel.textAlignment = .left
        toolbar.titleLabel.textColor = .white
    }
    
    @objc private func closeButtonPressed(sender: IconButton) {
        (rootViewController as? SelectTopicViewController)?.dismiss()
        dismiss(animated: true, completion: nil)
    }
}

