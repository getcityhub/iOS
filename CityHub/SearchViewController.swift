//
//  SearchViewController.swift
//  CityHub
//
//  Created by Jack Cook on 3/11/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import UIKit

class SearchViewController: UITableViewController, SearchToolbarControllerDelegate {
    
    // MARK: Properties
    
    private var activityIndicator: UIActivityIndicatorView!
    private var errorLabel: UILabel!
    
    private var postCells = [IndexPath: PostCard]()
    private var posts = [Post]()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toolbarController = toolbarController as? SearchToolbarController {
            toolbarController.searchDelegate = self
        }
        
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(white: 233/255, alpha: 1)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.estimatedRowHeight = 139
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.hidesWhenStopped = true
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
        
        if let toolbarController = toolbarController as? SearchToolbarController {
            toolbarController.searchBar.becomeFirstResponder()
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
    
    // MARK: SearchToolbarControllerDelegate Methods
    
    func searchBarTextUpdated(text: String) {
        activityIndicator.startAnimating()
        
        CityHubClient.shared.posts.getPosts { posts, error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            guard let posts = posts else {
                DispatchQueue.main.async {
                    self.errorLabel.alpha = 1
                    self.errorLabel.text = "There was an issue searching for posts. Please try again later."
                    
                    self.view.setNeedsLayout()
                    self.view.layoutIfNeeded()
                }
                
                return
            }
            
            self.posts = posts
            
            print("update")
            
            DispatchQueue.main.async {
                if posts.count == 0 && text.characters.count > 0 {
                    self.errorLabel.alpha = 1
                    self.errorLabel.text = "No posts match your query. Try searching for something else."
                } else {
                    self.errorLabel.alpha = 0
                }
                
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
                
                self.tableView.reloadData()
            }
        }
    }
}
