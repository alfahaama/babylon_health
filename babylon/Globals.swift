//
//  Globals.swift
//  babylon
//
//  Created by Julien Klindt on 21.03.16.
//  Copyright © 2016 Julien Klindt. All rights reserved.
//

import UIKit

class Globals {
    
    struct networkManager{
        
        static let apiPostsUrl = "http://jsonplaceholder.typicode.com/posts"
        static let apiUsersUrl = "http://jsonplaceholder.typicode.com/users"
        static let apiCommentsUrl = "http://jsonplaceholder.typicode.com/comments"
        static let apiAvatarUrl = "https://api.adorable.io/avatars/150/%@.png"
        static let updateFinished = "kNetworkUpdateFinished"
        
    }
    
    struct  networkCache {
        static let cachePosts = "kNetworkCachePosts"
        static let cacheUsers = "kNetworkCacheUsers"
        static let cacheComments = "kNetworkCacheComments"
    }
    
}
