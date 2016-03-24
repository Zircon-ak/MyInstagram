//
//  TimelineViewController.swift
//  MyInstagram
//
//  Created by Paethai Akarajariyakul on 3/22/16.
//  Copyright © 2016 mycompany. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    var photoTakingHelper : PhotoTakingHelper?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.delegate = self
    }
    
    func takePhoto(){
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) { (image:UIImage?) in
            print("received a callback")
        }
        
        //PhotoTakingHelper(viewController: self.tabBarController!, callback:
        //    {(image: UIImage?) in
        
        //})
    }
}

// MARK: Tab Bar Delegate

extension TimelineViewController: UITabBarControllerDelegate{
    
    func tabBarController(tabBarController: UITabBarController,
        shouldSelectViewController viewController: UIViewController) -> Bool{
            if( viewController is PhotoViewController) {
                takePhoto()
                return false
            }else {
                return true
            }
    }
}