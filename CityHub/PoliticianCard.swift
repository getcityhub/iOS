//
//  PoliticianCard.swift
//  CityHub
//
//  Created by Jack Cook on 05/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import AspectFillFaceAware
import STXImageCache
import UIKit

class PoliticianCard: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var cardBackground: UIView!
    @IBOutlet weak var profileImage: UIImageView?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
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
        
        profileImage?.layer.cornerRadius = 8
        
        phoneIcon.image = phoneIcon.image?.withRenderingMode(.alwaysTemplate)
        phoneIcon.tintColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
        
        emailIcon.image = emailIcon.image?.withRenderingMode(.alwaysTemplate)
        emailIcon.tintColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
        
        firstRun = false
    }
    
    // MARK: Public Methods
    
    func configure(_ politician: Politician) {
        if let photoUrl = politician.photoUrl, let url = URL(string: photoUrl) {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    self.profileImage?.set(image: image, focusOnFaces: true)
                }
            })
            
            task.resume()
        }
        
        nameLabel.text = politician.name
        
        if let position = politician.position {
            if let party = politician.party {
                positionLabel.text = "\(party) • \(position)"
            } else {
                positionLabel.text = "\(position)"
            }
        }
        
        phoneLabel.text = politician.phone
        emailLabel.text = politician.email
    }
}
