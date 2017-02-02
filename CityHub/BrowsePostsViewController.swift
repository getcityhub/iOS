//
//  BrowsePostsViewController.swift
//  CityHub
//
//  Created by Jack Cook on 30/01/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import UIKit

class BrowsePostsViewController: UIViewController, UITableViewDataSource {
    
    // MARK: Properties
    
    private var postsTableView: UITableView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toolbar = toolbarController?.toolbar {
            toolbar.contentEdgeInsets = EdgeInsets(top: 0, left: 24, bottom: 0, right: 12)
            toolbar.title = "Posts"
            toolbar.titleLabel.textColor = .white
            toolbar.titleLabel.textAlignment = .left
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if postsTableView == nil {
            postsTableView = UITableView()
            postsTableView.allowsSelection = false
            postsTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
            postsTableView.dataSource = self
            postsTableView.estimatedRowHeight = 139
            postsTableView.rowHeight = UITableViewAutomaticDimension
            postsTableView.separatorStyle = .none
            view.addSubview(postsTableView)
        }
        postsTableView.frame = view.bounds
    }
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = Bundle.main.loadNibNamed("PostCard", owner: self, options: nil)![0] as! PostCard
        card.configure(text: "Lorem ipsum dolor sit amet, everti equidem sed cu, diceret scripserit ei sed. Ius ridens epicuri ne, ex nobis invenire inimicus quo, aeque dictas his ex.")
        
        return card
    }
}
