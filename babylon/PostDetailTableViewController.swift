//
//  PostDetailTableViewController.swift
//  babylon
//
//  Created by Julien Klindt on 21.03.16.
//  Copyright © 2016 Julien Klindt. All rights reserved.
//

import UIKit
import Kingfisher

class PostDetailTableViewController: BaseTableViewController {

    var post: NSDictionary?
    
    class func createInstance(router: Router?, networkManager: NetworkManager?, post: NSDictionary?, dataManager: DataManager?) -> PostDetailTableViewController {
        let moduleStoryboard = UIStoryboard(name: "Posts", bundle: NSBundle(forClass: PostDetailTableViewController.self))
        let newViewControllerInstance = moduleStoryboard.instantiateViewControllerWithIdentifier("PostDetailTableViewController") as! PostDetailTableViewController
        newViewControllerInstance.router = router
        newViewControllerInstance.networkManager = networkManager
        newViewControllerInstance.post = post
        newViewControllerInstance.dataManager = dataManager
        return newViewControllerInstance
    }
    
    override func viewDidLoad() {
        
        self.title = self.post?.valueForKey("title") as? String ?? ""
        
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableViewAutomaticDimension
      
       
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("postDetailCellIdentifier") as! PostDetailCell
        
        
        if let postDict = self.post{
            
            let count = self.dataManager?.dataGetCommentsForPost(postDict.valueForKey("id") as! Int)
            cell.cellPostCommentsCount?.text = String(format: "comments %d", count ?? 0)
            cell.cellPostTitle?.text = postDict.valueForKey("title") as? String
            cell.cellPostBody?.text = postDict.valueForKey("body") as? String
            
            let tapGesture = UITapGestureRecognizer(target: self, action: "selectedUser:")
            cell.cellPostUser?.addGestureRecognizer(tapGesture)
            cell.cellPostUser?.userInteractionEnabled = true
            
            if let userDict = self.dataManager?.dataGetUserForPost(postDict.valueForKey("userId") as? Int ?? 0){
                cell.cellPostUser?.text = userDict.valueForKey("username") as? String ?? ""
                
                if let userEmail = userDict.valueForKey("email") as? String{
                    
                    let imageUrl = String(format: Globals.networkManager.apiAvatarUrl, userEmail)
                    cell.cellUserImage?.kf_setImageWithURL(NSURL(string: imageUrl)!, placeholderImage: UIImage(named: "placeholder"))
                }
            }
            
        }
        
        cell.selectionStyle = .None
        cell.userInteractionEnabled = true
        
        return cell
    }
    
    func selectedUser(tapGesture: UITapGestureRecognizer){
        
        
        if let postDict = self.post{
            
            if let userDict = self.dataManager?.dataGetUserForPost(postDict.valueForKey("userId") as? Int ?? 0){
                
                let userDetailVc = UserDetailViewController.createInstance(self.router, networkManager: self.networkManager, user: userDict, dataManager: self.dataManager)
                self.navigationController?.pushViewController(userDetailVc, animated: true)
                
            }
        }
        
        
    }
    
}
