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
    
    private var activityIndicator: UIActivityIndicatorView!
    private var errorLabel: UILabel!
    
    private var postCells = [IndexPath: PostCard]()
    private var posts = [Post]()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toolbar = toolbarController?.toolbar {
            toolbar.contentEdgeInsets = EdgeInsets(top: 0, left: 24, bottom: 0, right: 12)
            toolbar.title = "Posts".localized
            toolbar.titleLabel.textColor = .white
            toolbar.titleLabel.textAlignment = .left
        }
        
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(white: 233/255, alpha: 1)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.estimatedRowHeight = 139
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        errorLabel = UILabel()
        errorLabel.alpha = 0
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.textColor = UIColor(white: 0.25, alpha: 1)
        view.addSubview(errorLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CityHubClient.shared.posts.getPosts { posts, error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            guard let posts = posts else {
                DispatchQueue.main.async {
                    self.errorLabel.alpha = 1
                    self.errorLabel.text = "There was an issue retrieving nearby posts. Please try again later."
                    
                    self.view.setNeedsLayout()
                    self.view.layoutIfNeeded()
                }
                
                return
            }
            
            self.posts = posts
            
            DispatchQueue.main.async {
                if posts.count == 0 {
                    self.errorLabel.alpha = 1
                    self.errorLabel.text = "Nobody has posted in your area yet!\n\nYou can post something by tapping the new post button below."
                } else {
                    self.errorLabel.alpha = 0
                }
                
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        activityIndicator.sizeToFit()
        activityIndicator.frame = CGRect(x: (view.frame.size.width - activityIndicator.frame.size.width) / 2, y: (view.frame.size.height - activityIndicator.frame.size.height) / 2, width: activityIndicator.frame.size.width, height: activityIndicator.frame.size.height)
        
        let errorLabelFrame = errorLabel.textRect(forBounds: CGRect(x: 0, y: 0, width: view.frame.size.width - 64, height: CGFloat.greatestFiniteMagnitude), limitedToNumberOfLines: 10)
        errorLabel.frame = CGRect(x: (view.frame.size.width - errorLabelFrame.size.width) / 2, y: (view.frame.size.height - errorLabelFrame.size.height) / 2, width: errorLabelFrame.size.width, height: errorLabelFrame.size.height)
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
