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
    
    private var cardBackground: UIView!
    private var profileImage: UIImageView?
    private var nameLabel: UILabel!
    private var positionLabel: UILabel!
    private var contactImageViews: [UIImageView]!
    private var contactLabels: [UILabel]!
    
    private var politician: Politician!
    
    // MARK: View Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard politician != nil else {
            return
        }
        
        if cardBackground == nil {
            cardBackground = UIView()
            cardBackground.backgroundColor = .white
            cardBackground.layer.cornerRadius = 2
            addSubview(cardBackground)
            
            for imageView in contactImageViews {
                cardBackground.addSubview(imageView)
            }
            
            for label in contactLabels {
                cardBackground.addSubview(label)
            }
        }
        cardBackground.frame = CGRect(x: 16, y: 8, width: bounds.width - 32, height: bounds.height - 16)
        
        let shadowPath = UIBezierPath(rect: cardBackground.bounds)
        cardBackground.layer.masksToBounds = false
        cardBackground.layer.shadowColor = UIColor.black.cgColor
        cardBackground.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardBackground.layer.shadowOpacity = 0.35
        cardBackground.layer.shadowRadius = 2
        cardBackground.layer.shadowPath = shadowPath.cgPath
        
        profileImage?.layer.cornerRadius = 8
        
        if profileImage == nil && politician.photoUrl != nil {
            profileImage = UIImageView()
            profileImage?.masksToBounds = true
            cardBackground.addSubview(profileImage!)
            
            if let photoUrl = politician.photoUrl, let url = URL(string: photoUrl) {
                let session = URLSession(configuration: URLSessionConfiguration.default)
                
                let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        self.profileImage?.set(image: image, focusOnFaces: true)
                    }
                })
                
                task.resume()
            }
        }
        profileImage?.frame = CGRect(x: 16, y: 16, width: 56, height: 56)
        
        if nameLabel == nil {
            nameLabel = UILabel()
            nameLabel.font = UIFont.systemFont(ofSize: 22)
            nameLabel.text = politician.name
            nameLabel.textColor = .black
            cardBackground.addSubview(nameLabel)
        }
        nameLabel.sizeToFit()
        if let profileImage = profileImage {
            nameLabel.frame = CGRect(x: profileImage.frame.origin.x + profileImage.frame.size.width + 16, y: 20, width: nameLabel.frame.size.width, height: nameLabel.frame.size.height)
        } else {
            nameLabel.frame = CGRect(x: 16, y: 20, width: nameLabel.frame.size.width, height: nameLabel.frame.size.height)
        }
        
        if positionLabel == nil {
            positionLabel = UILabel()
            positionLabel.font = UIFont.systemFont(ofSize: 14)
            positionLabel.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
            cardBackground.addSubview(positionLabel)
            
            if let position = politician.position {
                if let party = politician.party {
                    positionLabel.text = "\(party) • \(position)"
                } else {
                    positionLabel.text = "\(position)"
                }
            }
        }
        positionLabel.sizeToFit()
        positionLabel.frame = CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y + nameLabel.frame.size.height + 4, width: positionLabel.frame.size.width, height: positionLabel.frame.size.height)
        
        for (idx, imageView) in contactImageViews.enumerated() {
            imageView.frame = CGRect(x: 32, y: idx == 0 ? positionLabel.frame.origin.y + positionLabel.frame.size.height + 16 : contactImageViews[idx - 1].frame.origin.y + contactImageViews[idx - 1].frame.size.height + 12, width: 24, height: 24)
        }
        
        for (idx, label) in contactLabels.enumerated() {
            let imageView = contactImageViews[idx]
            
            label.sizeToFit()
            label.frame = CGRect(x: imageView.frame.origin.x + imageView.frame.size.width + 32, y: imageView.frame.origin.y + (imageView.frame.size.height - label.frame.size.height) / 2, width: label.frame.size.width, height: label.frame.size.height)
        }
    }
    
    // MARK: Public Methods
    
    func configure(_ politician: Politician) {
        self.politician = politician
        
        var contactMethods = [(UIImage, String)]()
        
        func add(_ data: String?, _ image: UIImage) {
            if let data = data {
                contactMethods.append((image, data))
            }
        }
        
        add(politician.phone, #imageLiteral(resourceName: "Phone"))
        add(politician.email, #imageLiteral(resourceName: "Email"))
        add(politician.website, #imageLiteral(resourceName: "Website"))
        add(politician.facebook, #imageLiteral(resourceName: "Facebook"))
        add(politician.twitter, #imageLiteral(resourceName: "Twitter"))
        add(politician.youtube, #imageLiteral(resourceName: "YouTube"))
        add(politician.googleplus, #imageLiteral(resourceName: "Google Plus"))
        
        contactImageViews = [UIImageView]()
        contactLabels = [UILabel]()
        
        for (image, data) in contactMethods {
            let imageView = UIImageView()
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
            contactImageViews.append(imageView)
            
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.text = data
            label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
            contactLabels.append(label)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
