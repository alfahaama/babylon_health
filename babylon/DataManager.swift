//
//  DataManager.swift
//  babylon
//
//  Created by Julien Klindt on 21.03.16.
//  Copyright © 2016 Julien Klindt. All rights reserved.
//

import UIKit
import SwiftSpinner

class DataManager: NSObject {
    
    
    var networkManager: NetworkManager?
    
    
    
    func dataLoadAll(completion:(finished: Bool) -> Void){
        
        SwiftSpinner.show("Updating ...")
        
        self.networkManager?.apiGetPosts({ _ in
            
            self.networkManager?.apiGetUsers({ _ in
            
                self.networkManager?.apiGetComments({ _ in
                    
                    SwiftSpinner.hide()
                    completion(finished: true)
                
                })
                
            })
        
        })
                
    }
    
    func dataGetUserForPost(userId: Int) -> NSDictionary? {
        
        if let userDicts = networkManager?.networkCache?.getCachedResponse(Globals.networkCache.cacheUsers){
            
            for dict in userDicts{
                
                if dict.valueForKey("id") as? Int == userId{
                    return dict
                }
            }
        }
        
        return nil
    }
    
    func dataGetCommentsForPost(postId: Int) -> Int{
        
        if let commentsDict = networkManager?.networkCache?.getCachedResponse(Globals.networkCache.cacheComments){
            
            var counter = 0
            
            for dict in commentsDict{
                
                if dict.valueForKey("postId") as? Int == postId{
                    counter++
                }
            }
            
            return counter
        }
        
        return 0
        
    }
    
    
}
