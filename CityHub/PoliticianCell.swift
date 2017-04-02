//
//  PoliticianCell.swift
//  CityHub
//
//  Created by Jack Cook on 4/2/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class PoliticianCell: UITableViewCell {
    
    private var nameLabel: UILabel!
    private var positionLabel: UILabel!
    
    init(politician: Politician) {
        super.init(style: .default, reuseIdentifier: "PoliticianCell")
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.text = politician.name
        nameLabel.textColor = UIColor(white: 0, alpha: 0.5)
        addSubview(nameLabel)
        
        positionLabel = UILabel()
        positionLabel.font = UIFont.systemFont(ofSize: 12)
        positionLabel.text = politician.position ?? ""
        positionLabel.textColor = UIColor(white: 0, alpha: 0.5)
        addSubview(positionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: 16, y: 8, width: frame.size.width - 32, height: nameLabel.frame.size.height)
        
        positionLabel.sizeToFit()
        positionLabel.frame = CGRect(x: 16, y: nameLabel.frame.origin.y + nameLabel.frame.size.height + 3, width: frame.size.width - 32, height: positionLabel.frame.size.height)
    }
}
