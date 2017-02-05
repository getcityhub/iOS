//
//  CityHubMenuController.swift
//  CityHub
//
//  Created by Jack Cook on 03/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import Motion
import UIKit

class CityHubMenuController: MenuController, MenuDelegate {
    
    private let baseSize = CGSize(width: 56, height: 56)
    private let bottomInset: CGFloat = 24
    private let rightInset: CGFloat = 24
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare() {
        super.prepare()
        
        menu.baseSize = baseSize
        view.layout(menu).size(baseSize).bottom(bottomInset).right(rightInset)
        
        let addButton = FabButton(image: #imageLiteral(resourceName: "Add").withRenderingMode(.alwaysTemplate), tintColor: .white)
        addButton.pulseColor = .white
        addButton.backgroundColor = Color.red.base
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        let postButton = MenuItem()
        postButton.button.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
        postButton.button.image = #imageLiteral(resourceName: "Edit").withRenderingMode(.alwaysTemplate)
        postButton.button.tintColor = .white
        postButton.button.pulseColor = .white
        postButton.button.backgroundColor = Color.indigo.base
        postButton.title = "Write a post"
        
        let contactButton = MenuItem()
        contactButton.button.addTarget(self, action: #selector(contactButtonPressed), for: .touchUpInside)
        contactButton.button.image = #imageLiteral(resourceName: "Email").withRenderingMode(.alwaysTemplate)
        contactButton.button.tintColor = .white
        contactButton.button.pulseColor = .white
        contactButton.button.backgroundColor = Color.blue.base
        contactButton.title = "Contact your legislators"
        
        menu.delegate = self
        menu.views = [addButton, postButton, contactButton]
    }
    
    @objc private func addButtonPressed(sender: FabButton) {
        if menu.isOpened {
            closeMenu { view in
                (view as? MenuItem)?.hideTitleLabel()
            }
        } else {
            openMenu { view in
                (view as? MenuItem)?.showTitleLabel()
            }
        }
    }
    
    @objc private func postButtonPressed(sender: FabButton) {
        let pvc = CreatePostToolbarController(rootViewController: CreatePostViewController())
        
        present(pvc, animated: true) {
            self.closeMenu { view in
                (view as? MenuItem)?.hideTitleLabel()
            }
        }
    }
    
    @objc private func contactButtonPressed(sender: FabButton) {
        let pvc = BrowsePoliticiansToolbarController(rootViewController: BrowsePoliticiansViewController())
        
        present(pvc, animated: true) {
            self.closeMenu { view in
                (view as? MenuItem)?.hideTitleLabel()
            }
        }
    }
    
    override func openMenu(completion: ((UIView) -> Void)?) {
        super.openMenu(completion: completion)
        menu.views.first?.motion(.rotationAngle(45))
    }
    
    override func closeMenu(completion: ((UIView) -> Void)?) {
        super.closeMenu(completion: completion)
        menu.views.first?.motion(.rotationAngle(0))
    }
    
    func menu(menu: Menu, tappedAt point: CGPoint, isOutside: Bool) {
        guard isOutside else {
            return
        }
        
        closeMenu { view in
            (view as? MenuItem)?.hideTitleLabel()
        }
    }
}
