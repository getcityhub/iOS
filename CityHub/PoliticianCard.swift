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
    private var contactTextButtons: [UIButton]!
    
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
            
            for button in contactTextButtons {
                cardBackground.addSubview(button)
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
        
        for (idx, button) in contactTextButtons.enumerated() {
            let imageView = contactImageViews[idx]
            
            button.sizeToFit()
            button.frame = CGRect(x: imageView.frame.origin.x + imageView.frame.size.width + 32, y: imageView.frame.origin.y + (imageView.frame.size.height - button.frame.size.height) / 2, width: button.frame.size.width, height: button.frame.size.height)
        }
    }
    
    // MARK: Public Methods
    
    func configure(_ politician: Politician) {
        self.politician = politician
        
        var contactMethods = [(Int, UIImage, String)]()
        
        func add(_ position: Int, _ data: String?, _ image: UIImage) {
            if let data = data {
                contactMethods.append((position, image, data))
            }
        }
        
        add(1, politician.phone, #imageLiteral(resourceName: "Phone"))
        add(2, politician.email, #imageLiteral(resourceName: "Email"))
        add(3, politician.website, #imageLiteral(resourceName: "Website"))
        add(4, politician.facebook, #imageLiteral(resourceName: "Facebook"))
        add(5, politician.twitter, #imageLiteral(resourceName: "Twitter"))
        add(6, politician.youtube, #imageLiteral(resourceName: "YouTube"))
        add(7, politician.googleplus, #imageLiteral(resourceName: "Google Plus"))
        
        contactImageViews = [UIImageView]()
        contactTextButtons = [UIButton]()
        
        for (position, image, data) in contactMethods {
            let imageView = UIImageView()
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
            contactImageViews.append(imageView)
            
            let button = UIButton()
            button.addTarget(self, action: #selector(contactButtonPressed(sender:)), for: .touchUpInside)
            button.setTitle(data, for: .normal)
            button.setTitleColor(UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1), for: .normal)
            button.tag = position
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            contactTextButtons.append(button)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    // MARK: Private Methods
    
    @objc private func contactButtonPressed(sender: UIButton) {
        var url: URL?
        var backupURL: URL?
        
        switch sender.tag {
        case 1:
            if let phone = politician.phone {
                let phoneNumber = phone.replacingOccurrences(of: "(", with: "")
                    .replacingOccurrences(of: ")", with: "")
                    .replacingOccurrences(of: " ", with: "")
                    .replacingOccurrences(of: "-", with: "")
                url = URL(string: "tel://\(phoneNumber)")
            }
        case 2:
            if let email = politician.email {
                url = URL(string: "mailto:\(email)")
            }
        case 3:
            if let website = politician.website {
                url = URL(string: website)
            }
        case 4:
            if let facebook = politician.facebook {
                url = URL(string: "https://facebook.com/\(facebook)")
            }
        case 5:
            if let twitter = politician.twitter {
                url = URL(string: "twitter://user?screen_name=\(twitter)")
                backupURL = URL(string: "https://twitter.com/\(twitter)")
            }
        case 6:
            if let youtube = politician.youtube {
                url = URL(string: "youtube://user/\(youtube)")
                backupURL = URL(string: "https://youtube.com/\(youtube)")
            }
        case 7:
            if let googleplus = politician.googleplus {
                url = URL(string: "gplus://plus.google.com/\(googleplus)")
                backupURL = URL(string: "https://plus.google.com/\(googleplus)")
            }
        default:
            break
        }
        
        if let url = url {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
                return
            }
        }
        
        if let backupURL = backupURL {
            if UIApplication.shared.canOpenURL(backupURL) {
                UIApplication.shared.openURL(backupURL)
                return
            }
        }
    }
}
