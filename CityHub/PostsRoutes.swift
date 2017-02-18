//
//  PostsRoutes.swift
//  CityHub
//
//  Created by Jack Cook on 12/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import SwiftyJSON

class PostsRoutes {
    
    func createPost(authorId: Int, title: String, categoryId: Int, language: String, text: String, completion: ((_ post: Post?, _ error: CityHubRequestError?) -> Void)?) {
        let body = [
            "authorId": authorId,
            "title": title,
            "categoryId": categoryId,
            "language": language,
            "text": text
        ] as [String : Any]
        
        CityHubRequest.request("/posts", requestType: "POST", body: body) { json, error in
            guard let json = json else {
                completion?(nil, error)
                return
            }
            
            let post = Post(json: json)
            completion?(post, error)
        }
    }
    
    func getPosts(categoryId: Int?, language: String?, zipcode: String?, completion: ((_ posts: [Post]?, _ error: CityHubRequestError?) -> Void)?) {
        var params = [String: String]()
        
        if let categoryId = categoryId {
            params["cid"] = "\(categoryId)"
        }
        
        if let language = language {
            params["lang"] = language
        }
        
        if let zipcode = zipcode {
            params["zip"] = zipcode
        }
        
        CityHubRequest.request("/posts", params: params) { json, error in
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
