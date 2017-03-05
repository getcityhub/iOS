//
//  SettingsViewController.swift
//  CityHub
//
//  Created by Jack Cook on 3/4/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(white: 233/255, alpha: 1)
        tableView.contentInset = UIEdgeInsets(top: -48, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        
        let dummyView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 60))
        tableView.tableHeaderView = dummyView
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsTextCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SettingsHeaderView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(white: 233/255, alpha: 1)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
}
