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
        switch section {
        case 0: return 1
        case 1: return 2
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = SettingsTextCell()
            cell.configure("Log In", "")
            return cell
        case (1, 0):
            let cell = SettingsTextCell()
            cell.configure("Send Feedback", "")
            return cell
        case (1, 1):
            let cell = SettingsTextCell()
            
            if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
                let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String {
                cell.configure("Version", "\(version) (\(build))")
            } else {
                cell.configure("Version", "?")
            }
            
            return cell
        default:
            break
        }
        
        return SettingsCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SettingsHeaderView()
        
        switch section {
        case 0:
            view.configure("Account")
        case 1:
            view.configure("About")
        default:
            break
        }
        
        return view
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let lvc = LoginViewController()
            present(lvc, animated: true, completion: nil)
        case (1, 0):
            print("send feedback")
        default:
            break
        }
    }
}
