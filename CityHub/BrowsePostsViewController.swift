//
//  BrowsePostsViewController.swift
//  CityHub
//
//  Created by Jack Cook on 30/01/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class BrowsePostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var statusBarBackground: UIView!
    @IBOutlet weak var menuBar: UIView!
    @IBOutlet weak var postsTableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        postsTableView.dataSource = self
        postsTableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let menuBarShadowPath = UIBezierPath(rect: menuBar.bounds)
        menuBar.layer.cornerRadius = 0
        menuBar.layer.masksToBounds = false
        menuBar.layer.shadowColor = UIColor.black.cgColor
        menuBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        menuBar.layer.shadowOpacity = 0.5
        menuBar.layer.shadowRadius = 2
        menuBar.layer.shadowPath = menuBarShadowPath.cgPath
    }
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = Bundle.main.loadNibNamed("PostCard", owner: self, options: nil)![0] as! PostCard
        card.configure(text: "This is my post")
        
        let cell = CardCell(card: card)
        return cell
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}
