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
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var favorited = false
    private var firstRun = true
    private var post: Post?
    
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
            moreButton.tintColor = UIColor(red: 96/255, green: 125/255, blue: 139/255, alpha: 1)
            favoriteButton.tintColor = UIColor(red: 96/255, green: 125/255, blue: 139/255, alpha: 1)
        }
        
        firstRun = false
    }
    
    // MARK: Public Methods
    
    func configure(text: String) {
        contentLabel.text = text
    }
    
    // MARK: IBActions
    
    @IBAction func moreButtonPressed(sender: UIButton) {
        let controller = UIAlertController(title: nil, message: "What would you like to do with this post?", preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            
        }
        
        let reportAction = UIAlertAction(title: "Report", style: .destructive) { (action) in
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        controller.addAction(saveAction)
        controller.addAction(reportAction)
        controller.addAction(cancelAction)
        
        viewController?.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func favoriteButtonPressed(sender: UIButton) {
        favorited = !favorited
        
        if favorited {
            favoriteButton.setImage(#imageLiteral(resourceName: "Favorite"), for: .normal)
            favoriteButton.tintColor = UIColor(red: 244/255, green: 67/255, blue: 54/255, alpha: 1)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "Favorite Border"), for: .normal)
            favoriteButton.tintColor = UIColor(red: 96/255, green: 125/255, blue: 139/255, alpha: 1)
        }
    }
}
