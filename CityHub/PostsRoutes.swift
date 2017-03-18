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
        ] as [String: Any]
        
        CityHubRequest.request("/posts", requestType: "POST", body: body) { json, error in
            guard let json = json else {
                completion?(nil, error)
                return
            }
            
            let post = Post(json: json)
            completion?(post, error)
        }
    }
    
    func getPosts(query: String? = nil, completion: ((_ posts: [Post]?, _ error: CityHubRequestError?) -> Void)?) {
        var params = [String: String]()
        
        if let query = query {
            params["q"] = query
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
    
    func likePost(postId: Int, completion: ((_ error: CityHubRequestError?) -> Void)?) {
        CityHubRequest.request("/posts/\(postId)/like", requestType: "POST") { json, error in
            completion?(error)
        }
    }
    
    func unlikePost(postId: Int, completion: ((_ error: CityHubRequestError?) -> Void)?) {
        CityHubRequest.request("/posts/\(postId)/unlike", requestType: "POST") { json, error in
            completion?(error)
        }
    }
}
