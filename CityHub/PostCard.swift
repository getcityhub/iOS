//
//  PostCard.swift
//  CityHub
//
//  Created by Jack Cook on 30/01/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class PostCard: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var cardBackground: UIView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
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
    }
    
    // MARK: Public Methods
    
    func configure(text: String) {
        contentLabel.text = text
    }
}
