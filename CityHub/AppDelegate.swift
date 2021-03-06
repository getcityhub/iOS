//
//  AppDelegate.swift
//  CityHub
//
//  Created by Jack Cook on 30/01/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let rvc = CityHubMenuController(rootViewController: CityHubToolbarController(rootViewController: BrowsePostsViewController()))
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rvc
        window?.makeKeyAndVisible()
        
        return true
    }
}
