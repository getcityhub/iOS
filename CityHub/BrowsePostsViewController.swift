//
//  BrowsePostsViewController.swift
//  CityHub
//
//  Created by Jack Cook on 30/01/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import UIKit

class BrowsePostsViewController: UITableViewController {
    
    // MARK: Properties
    
    private var postCells = [IndexPath: UITableViewCell]()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toolbar = toolbarController?.toolbar {
            toolbar.contentEdgeInsets = EdgeInsets(top: 0, left: 24, bottom: 0, right: 12)
            toolbar.title = "Posts"
            toolbar.titleLabel.textColor = .white
            toolbar.titleLabel.textAlignment = .left
        }
        
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.estimatedRowHeight = 139
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
    }
    
    // MARK: UITableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = postCells[indexPath] {
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("PostCard", owner: self, options: nil)![0] as! PostCard
            cell.configure(text: "Lorem ipsum dolor sit amet, everti equidem sed cu, diceret scripserit ei sed. Ius ridens epicuri ne, ex nobis invenire inimicus quo, aeque dictas his ex.")
            
            postCells[indexPath] = cell
            return cell
        }
    }
}
