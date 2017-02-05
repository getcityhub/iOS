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
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.estimatedRowHeight = 104
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
    }
    
    // MARK: UITableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = politicianCells[indexPath] {
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("PoliticianCard", owner: self, options: nil)![0] as! PoliticianCard
            politicianCells[indexPath] = cell
            return cell
        }
    }
}
