//
//  NetworkCache.swift
//  babylon
//
//  Created by Julien Klindt on 21.03.16.
//  Copyright © 2016 Julien Klindt. All rights reserved.
//

import UIKit

class NetworkCache: NSObject {
    
    
    func clearCache(){
        
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: Globals.networkCache.cacheComments)
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: Globals.networkCache.cachePosts)
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: Globals.networkCache.cacheUsers)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func cacheApiResponse(responseDict: [NSDictionary]?, key: String){
        
        NSUserDefaults.standardUserDefaults().setValue(responseDict, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func getCachedResponse(key: String) -> [NSDictionary]? {
        
        return NSUserDefaults.standardUserDefaults().valueForKey(key) as? [NSDictionary] ?? [NSDictionary]()
    }
  
    
}
