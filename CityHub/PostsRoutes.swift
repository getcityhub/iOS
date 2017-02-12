//
//  PostsRoutes.swift
//  CityHub
//
//  Created by Jack Cook on 12/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import SwiftyJSON

class PostsRoutes {
    
    func getPosts(completion: ((_ posts: [Post]?, _ error: CityHubRequestError?) -> Void)?) {
        CityHubRequest.request("/posts") { json, error in
            guard let posts = json?.array else {
                completion?(nil, error)
                return
            }
            
            var retrievedPosts = [Post]()
            
            for post in posts {
                let retrievedPost = Post(json: post)
                retrievedPosts.append(retrievedPost)
            }
            
            completion?(retrievedPosts, error)
        }
    }
}
