//
//  PoliticianCard.swift
//  CityHub
//
//  Created by Jack Cook on 05/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class PoliticianCard: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var cardBackground: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    private var firstRun = true
    
    // MARK: View Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cardBackground.layer.cornerRadius = 2
        
        let shadowPath = UIBezierPath(rect: cardBackground.bounds)
        cardBackground.layer.masksToBounds = false
        cardBackground.layer.shadowColor = UIColor.black.cgColor
        cardBackground.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardBackground.layer.shadowOpacity = 0.35
        cardBackground.layer.shadowRadius = 2
        cardBackground.layer.shadowPath = shadowPath.cgPath
        
        if firstRun {
            
        }
        
        firstRun = false
    }
}
