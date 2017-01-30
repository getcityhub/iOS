//
//  CardCell.swift
//  CityHub
//
//  Created by Jack Cook on 30/01/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
    
    // MARK: Properties
    
    private var card: UIView!
    
    // MARK: Initializers
    
    public init(card: UIView) {
        super.init(style: .default, reuseIdentifier: "CardCell")
        
        self.card = card
        addSubview(card)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        card.frame = CGRect(x: 16, y: 8, width: frame.size.width - 32, height: frame.size.height - 16)
    }
}
