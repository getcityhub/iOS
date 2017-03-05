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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CityHubClient.shared.politicians.getPoliticians(zipcode: "10028") { (politicians, error) in
            guard let politicians = politicians else {
                return
            }
            
            self.politicians = politicians
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
