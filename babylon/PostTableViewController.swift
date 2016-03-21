//
//  PostTableViewController.swift
//  babylon
//
//  Created by Julien Klindt on 21.03.16.
//  Copyright © 2016 Julien Klindt. All rights reserved.
//

import UIKit

class PostTableViewController: BaseTableViewController {

    var postDicts: [NSDictionary]?
    
    class func createInstance(router: Router?, networkManager: NetworkManager?, dataManager: DataManager?) -> PostTableViewController {
        let moduleStoryboard = UIStoryboard(name: "Posts", bundle: NSBundle(forClass: PostTableViewController.self))
        let newViewControllerInstance = moduleStoryboard.instantiateViewControllerWithIdentifier("PostTableViewController") as! PostTableViewController
        newViewControllerInstance.router = router
        newViewControllerInstance.networkManager = networkManager
        newViewControllerInstance.dataManager = dataManager
        return newViewControllerInstance
    }
    
    
    override func viewDidLoad() {
        
        
        self.title = "Posts"
        
        self.tableView.estimatedRowHeight = 40
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.postDicts = self.networkManager?.networkCache?.getCachedResponse(Globals.networkCache.cachePosts)
        self.tableView.reloadData()
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postDicts?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("postCellIdentifier") as! PostCell
        
        if let postDict = self.postDicts?[indexPath.row]{
            
            cell.cellPostTitle?.text = postDict.valueForKey("title") as? String
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let postDict = self.postDicts?[indexPath.row]{
            
            let postDetailVc = PostDetailTableViewController.createInstance(self.router, networkManager: self.networkManager, post: postDict, dataManager: self.dataManager)
            self.navigationController?.pushViewController(postDetailVc, animated: true)
        }
        
    }
    
    
}
