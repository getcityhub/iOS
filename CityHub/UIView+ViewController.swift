//
//  UIView+ViewController.swift
//  CityHub
//
//  Created by Jack Cook on 02/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

extension UIView {
    
    var viewController: UIViewController? {
        guard let responder = next else {
            return nil
        }
        
        if let viewController = responder as? UIViewController {
            return viewController
        } else if let view = responder as? UIView {
            return view.viewController
        } else {
            return nil
        }
    }
}
