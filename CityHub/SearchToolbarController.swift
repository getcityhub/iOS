//
//  SearchToolbarController.swift
//  CityHub
//
//  Created by Jack Cook on 3/11/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import UIKit

class SearchToolbarController: ToolbarController, SearchBarDelegate {
    
    var searchDelegate: SearchToolbarControllerDelegate?
    
    private var closeButton: IconButton!
    private var searchBar: SearchBar!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare() {
        super.prepare()
        
        closeButton = IconButton(image: #imageLiteral(resourceName: "Close").withRenderingMode(.alwaysTemplate), tintColor: .white)
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        closeButton.pulseColor = .white
        
        searchBar = SearchBar()
        searchBar.backgroundColor = .clear
        searchBar.clearButton.tintColor = UIColor(red: 207/255, green: 216/255, blue: 220/255, alpha: 1)
        searchBar.placeholderColor = UIColor(red: 207/255, green: 216/255, blue: 220/255, alpha: 1)
        searchBar.textColor = .white
        searchBar.leftViews = [closeButton]
        
        statusBar.backgroundColor = Color.blue.darken3
        
        toolbar.backgroundColor = Color.blue.darken2
        toolbar.centerViews = [searchBar]
    }
    
    @objc private func closeButtonPressed(sender: IconButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchBar(searchBar: SearchBar, didChange textField: UITextField, with text: String?) {
        searchDelegate?.searchBarTextUpdated(text: text ?? "")
    }
}

protocol SearchToolbarControllerDelegate {
    func searchBarTextUpdated(text: String)
}
