//
//  Router.swift
//  babylon
//
//  Created by Julien Klindt on 21.03.16.
//  Copyright © 2016 Julien Klindt. All rights reserved.
//

import UIKit
import DrawerController

class Router {
    
    var window: UIWindow
    
    lazy var networkManager: NetworkManager? = {
        return NetworkManager()
    }()
    
    var drawerController: DrawerController?
    
    lazy var dataManager: DataManager? = {
        return DataManager()
    }()
    
    
    init(window: UIWindow) {
        self.window = window
        
        self.networkManager?.networkCache = NetworkCache()
        self.dataManager?.networkManager = self.networkManager
        
        
        drawerController = DrawerController(centerViewController: getModule_PostTableView(), leftDrawerViewController: nil)
        self.window.rootViewController = drawerController
        self.window.makeKeyAndVisible()
        
        self.dataManager?.dataLoadAll({
            _ in
            NSNotificationCenter.defaultCenter().postNotificationName(Globals.networkManager.updateFinished, object: nil)
        })
        
    }
    
    
    //MARK: Modules
    
    private func getModule_PostTableView() -> UIViewController {
        let postTableVc = PostTableViewController.createInstance(self, networkManager: self.networkManager, dataManager: self.dataManager)
        return UINavigationController(rootViewController: postTableVc)
    }

    private func getModule_PostDetailTableView(post: NSDictionary?) -> UIViewController {
        let postTableVc = PostDetailTableViewController.createInstance(self, networkManager: self.networkManager, post: post, dataManager: self.dataManager)
        return UINavigationController(rootViewController: postTableVc)
    }
    
    
}