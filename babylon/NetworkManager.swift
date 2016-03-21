//
//  NetworkManager.swift
//  babylon
//
//  Created by Julien Klindt on 21.03.16.
//  Copyright © 2016 Julien Klindt. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    var networkCache: NetworkCache?
    
    
    func apiGetPosts(completion:(posts: [NSDictionary]?) -> Void){
        
        if(Reachability.isConnectedToNetwork() == false){
            
            completion(posts: self.networkCache?.getCachedResponse(Globals.networkCache.cachePosts))
            return
            
        }else{
            
            Alamofire.request(.GET, Globals.networkManager.apiPostsUrl).responseJSON(completionHandler: {
                
                response in
                
                if let JSON = response.result.value {
                    
                    if let responseDicts = JSON as? [NSDictionary]{
                        
                        self.networkCache?.cacheApiResponse(responseDicts, key: Globals.networkCache.cachePosts)
                        completion(posts: responseDicts)
                        return
                    }
                    
                }
                
                completion(posts: nil)
            })
        }
        
    }
    
    func apiGetUsers(completion:(users: [NSDictionary]?) -> Void){
        
        if(Reachability.isConnectedToNetwork() == false){
            
            completion(users: self.networkCache?.getCachedResponse(Globals.networkCache.cacheUsers))
            return
            
        }else{
            
            Alamofire.request(.GET, Globals.networkManager.apiUsersUrl).responseJSON(completionHandler: {
                
                response in
                
                if let JSON = response.result.value {
                    
                    if let responseDicts = JSON as? [NSDictionary]{
                        
                        self.networkCache?.cacheApiResponse(responseDicts, key: Globals.networkCache.cacheUsers)
                        completion(users: responseDicts)
                        return
                    }
                    
                }
                
                completion(users: nil)
            })
        }
        
    }
    
    func apiGetComments(completion:(comments: [NSDictionary]?) -> Void){
        
        if(Reachability.isConnectedToNetwork() == false){
            
            completion(comments: self.networkCache?.getCachedResponse(Globals.networkCache.cacheComments))
            return
            
        }else{
            
            Alamofire.request(.GET, Globals.networkManager.apiCommentsUrl).responseJSON(completionHandler: {
                
                response in
                
          
                if let JSON = response.result.value {
                    
                    if let responseDicts = JSON as? [NSDictionary]{
                        
                        self.networkCache?.cacheApiResponse(responseDicts, key: Globals.networkCache.cacheComments)
                        completion(comments: responseDicts)
                        return
                    }
                    
                }
                
                completion(comments: nil)
            })
        }
        
    }
    
    
}
