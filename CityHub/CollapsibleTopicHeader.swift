//
//  CollapsibleTopicHeader.swift
//  CityHub
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Material
import UIKit

class CollapsibleTopicHeader: UITableViewHeaderFooterView {
    
    var delegate: CollapsibleTopicHeaderDelegate?
    var section = 0
    
    var isCollapsed = true {
        didSet {
            arrowLabel.animate(animation: Motion.rotate(angle: isCollapsed ? 0 : 90))
        }
    }
    
    var titleLabel: UILabel!
    var arrowLabel: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        arrowLabel = UILabel()
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(arrowLabel)
        
        titleLabel = UILabel()
        titleLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        let tgr = UITapGestureRecognizer(target: self, action: #selector(tapHeader))
        addGestureRecognizer(tgr)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        
        let views: [String: UIView] = [
            "titleLabel": titleLabel,
            "arrowLabel": arrowLabel
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[titleLabel]-[arrowLabel]-20-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel]-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[arrowLabel]-|", options: [], metrics: nil, views: views))
    }
    
    @objc private func tapHeader(gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTopicHeader else {
            return
        }
        
        delegate?.toggleSection(header: self, section: cell.section)
    }
}

protocol CollapsibleTopicHeaderDelegate {
    func toggleSection(header: CollapsibleTopicHeader, section: Int)
}
