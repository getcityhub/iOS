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
    @IBOutlet weak var likeButton: UIButton!
    
    private var liked = false
    private var firstRun = true
    private var post: Post?
    
    // MARK: View Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        
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
            likeButton.tintColor = UIColor(red: 96/255, green: 125/255, blue: 139/255, alpha: 1)
        }
        
        firstRun = false
    }
    
    // MARK: Public Methods
    
    func configure(_ post: Post) {
        self.post = post
        
        titleLabel.text = post.title
        authorLabel.text = "by".localized + (post.author.anonymous ? "Anonymous".localized : "\(post.author.firstName) \(post.author.lastName)")
        contentLabel.text = post.text
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateLabel.text = formatter.string(from: post.createdAt)
    }
    
    // MARK: IBActions
    
    @IBAction func moreButtonPressed(sender: UIButton) {
        let controller = UIAlertController(title: nil, message: "What would you like to do with this post?".localized, preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Save".localized, style: .default) { (action) in
            
        }
        
        let reportAction = UIAlertAction(title: "Report".localized, style: .destructive) { (action) in
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
        controller.addAction(saveAction)
        controller.addAction(reportAction)
        controller.addAction(cancelAction)
        
        viewController?.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func likeButtonPressed(sender: UIButton) {
        guard let post = post else {
            return
        }
        
        liked = !liked
        
        if liked {
            likeButton.setImage(#imageLiteral(resourceName: "Like"), for: .normal)
            likeButton.tintColor = UIColor(red: 244/255, green: 67/255, blue: 54/255, alpha: 1)
            
            CityHubClient.shared.posts.likePost(postId: post.id, completion: nil)
        } else {
            likeButton.setImage(#imageLiteral(resourceName: "Like Border"), for: .normal)
            likeButton.tintColor = UIColor(red: 96/255, green: 125/255, blue: 139/255, alpha: 1)
            
            CityHubClient.shared.posts.unlikePost(postId: post.id, completion: nil)
        }
    }
}
