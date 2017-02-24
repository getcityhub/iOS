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
    
    private var postCells = [IndexPath: PostCard]()
    private var posts = [Post]()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CityHubClient.shared.posts.getPosts(categoryId: nil, language: nil, zipcode: nil) { (posts, error) in
            guard let posts = posts else {
                return
            }
            
            self.posts = posts
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        if let toolbar = toolbarController?.toolbar {
            toolbar.contentEdgeInsets = EdgeInsets(top: 0, left: 24, bottom: 0, right: 12)
            toolbar.title = "Posts".localized
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
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = postCells[indexPath] {
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("PostCard", owner: self, options: nil)![0] as! PostCard
            cell.configure(posts[indexPath.row])
            
            postCells[indexPath] = cell
            return cell
        }
    }
}
