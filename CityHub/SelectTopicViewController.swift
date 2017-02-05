//
//  SelectTopicViewController.swift
//  CityHub
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class SelectTopicViewController: UITableViewController, CollapsibleTopicHeaderDelegate {
    
    private var completionBlock: ((_ topic: String?) -> Void)?
    private var sections = [TopicSection]()
    
    private var selectedIndexPath: IndexPath?
    private var selectedTopic: String?
    
    init(completion: ((_ topic: String?) -> Void)?) {
        super.init(style: .plain)
        completionBlock = completion
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        sections = [
            TopicSection(name: "Your Home", items: ["Apartment Conditions", "Heat or Hot Water", "Water Quality", "Water Leak", "Sewer Backup", "Mold", "Garbage Collection", "Bed Bugs", "Power Outage", "Other"], collapsed: true),
            TopicSection(name: "Noise", items: ["Neighbor", "Club or Bar", "Street or Sidewalk", "Large Party/Crowd", "Construction", "Dog", "Store or Business", "Vehicle", "Air Conditioner/Vent", "Alarm", "Other"], collapsed: true),
            TopicSection(name: "Vehicles & Parking", items: ["Illegal Parking", "Blocking Driveway", "Abandoned Vehicle", "Commercial Vehicle", "Towed Vehicle", "Parking Ticket", "Parking Meter", "Red Light Camera", "Other"], collapsed: true),
            TopicSection(name: "Transportation", items: ["Bus/Subway/Railroad", "SI Ferry", "Yellow Taxi", "Green Taxi", "Car Service", "Bus Stop Shelter", "Other"], collapsed: true),
            TopicSection(name: "Streets & Sidewalks", items: ["Street Pothole", "Highway Surface", "Blocked Sidewalk/St", "Damaged Sidewalk", "Damaged Curb", "Street Sign", "Traffic Signal", "Street Light", "Illegal Poster", "Damaged Tree", "Dirty Sidewalk", "Catch Basin", "Fire Hydrant", "Water Leak", "Other"], collapsed: true),
            TopicSection(name: "Public Health/Safety", items: ["Garbage Collection", "Garbage Storage", "Dirty Sidewalk", "Damaged Tree", "Rodents", "Dog or Animal Waste", "Animal Abuse", "Food Safety", "Food Poisoning", "Homeless Person", "Other"], collapsed: true)
        ]
    }
    
    func dismiss() {
        completionBlock?(selectedTopic)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].collapsed ? 0 : 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CollapsibleTopicHeader(reuseIdentifier: "Header")
        
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.isCollapsed = sections[section].collapsed
        header.section = section
        header.delegate = self
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func toggleSection(header: CollapsibleTopicHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        sections[section].collapsed = collapsed
        header.isCollapsed = collapsed
        
        tableView.beginUpdates()
        
        for i in 0..<sections[section].items.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndexPath = selectedIndexPath {
            tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .none
        }
        
        selectedIndexPath = indexPath
        selectedTopic = sections[indexPath.section].items[indexPath.row]
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
}

struct TopicSection {
    var name: String
    var items: [String]
    var collapsed: Bool
}
