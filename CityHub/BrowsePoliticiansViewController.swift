//
//  BrowsePoliticiansViewController.swift
//  CityHub
//
//  Created by Jack Cook on 05/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class BrowsePoliticiansViewController: UITableViewController {
    
    // MARK: Properties
    
    private var activityIndicator: UIActivityIndicatorView!
    private var errorLabel: UILabel!
    
    private var politicianCells = [IndexPath: UITableViewCell]()
    private var politicians = [Politician]()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(white: 233/255, alpha: 1)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.estimatedRowHeight = 104
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
        
        CityHubClient.shared.politicians.getPoliticians(zipcode: "10028") { politicians, error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            guard let politicians = politicians else {
                DispatchQueue.main.async {
                    self.errorLabel.alpha = 1
                    self.errorLabel.text = "There was an issue retrieving your local politicians. Please try again later."
                    
                    self.view.setNeedsLayout()
                    self.view.layoutIfNeeded()
                }
                
                return
            }
            
            self.politicians = politicians
            
            DispatchQueue.main.async {
                if politicians.count == 0 {
                    self.errorLabel.alpha = 1
                    self.errorLabel.text = "There was an issue retrieving your local politicians. Please try again later."
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
        return politicians.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var contactMethods = 0
        
        let politician = politicians[indexPath.row]
        
        func check(_ data: String?) {
            if data != nil {
                contactMethods += 1
            }
        }
        
        check(politician.phone)
        check(politician.email)
        check(politician.website)
        check(politician.facebook)
        check(politician.twitter)
        check(politician.youtube)
        check(politician.googleplus)
        
        var contactMethodsHeight: CGFloat = 0
        
        if contactMethods > 0 {
            contactMethodsHeight = 16 + CGFloat(contactMethods) * 36 - 12
        } else {
            contactMethodsHeight = 0
        }
        
        return 104 + contactMethodsHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = politicianCells[indexPath] {
            return cell
        } else {
            let politician = politicians[indexPath.row]
            
            let cell = PoliticianCard()
            cell.configure(politician)
            
            politicianCells[indexPath] = cell
            return cell
        }
    }
}
