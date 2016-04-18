//
//  TimelineViewController.swift
//  MyInstagram
//
//  Created by Paethai Akarajariyakul on 3/22/16.
//  Copyright © 2016 mycompany. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var photoTakingHelper : PhotoTakingHelper?
    var kumulos : Kumulos?
    var postListData : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.delegate = self
        
        kumulos = Kumulos()
        postListData = NSMutableArray()
        kumulos?.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        kumulos?.getPostsWithPostOwner(1)
    }
    
    func takePhoto(photoViewController : PhotoViewController){
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) { (image:UIImage?) in
            if let image = image {
                self.tabBarController?.selectedViewController = photoViewController
                photoViewController.imgCurrentPhoto.image = image
                photoViewController.txtDescription.text = nil
            }
        }
        
        //PhotoTakingHelper(viewController: self.tabBarController!, callback:
        //    {(image: UIImage?) in
        
        //})
    }
}

// MARK: Table View Data Source
extension TimelineViewController : UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postListData?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        
        if let list = postListData?.objectAtIndex(indexPath.row){
            let listDictionary = list as! NSDictionary
            
            cell.txtDescription.text = listDictionary.valueForKey("description") as! String
            
            let photos = listDictionary.valueForKey("photos") as! NSArray
            
            let firstPhoto = photos.firstObject as! NSDictionary
           
            let imageData = firstPhoto.valueForKey("imageData") as! NSData
            
            cell.postImage.image = UIImage(data: imageData)
         
        }
        return cell
    }
}

// MARK: Kumulos Delegate
extension TimelineViewController : KumulosDelegate {
    func kumulosAPI(kumulos: Kumulos!, apiOperation operation: KSAPIOperation!, getPostsDidCompleteWithResult theResults: [AnyObject]!) {
        
        postListData?.removeAllObjects()
        postListData?.addObjectsFromArray(theResults)
        self.tableView.reloadData()
        
    }
}

// MARK: Tab Bar Delegate

extension TimelineViewController: UITabBarControllerDelegate{
    
    func tabBarController(tabBarController: UITabBarController,
        shouldSelectViewController viewController: UIViewController) -> Bool{
            if( viewController is PhotoViewController) {
                takePhoto(viewController as! PhotoViewController)
                return false
            }else {
                return true
            }
    }
}