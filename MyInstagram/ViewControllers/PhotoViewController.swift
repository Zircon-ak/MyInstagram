//
//  PhotosViewController.swift
//  MyInstagram
//
//  Created by Paethai Akarajariyakul on 3/22/16.
//  Copyright © 2016 mycompany. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var imgCurrentPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.resizedImageData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.resizedImageData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btPostOnClick(sender: AnyObject) {
        let objKumulos = Kumulos()
        let imageNSData = UIImageJPEGRepresentation(imgCurrentPhoto.image! , 1)
        objKumulos.createPostWithDescription(txtDescription.text, andPostOwner: 1, andImageData: imageNSData)
        
    }

    @IBAction func btCancelOnClick(sender: AnyObject) {
        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers?.first
    }
    
    func resizedImageData() {
        if let originalImage = imgCurrentPhoto.image {
            let resize : CGFloat = 256.0
            let actualWidth = originalImage.size.width
            let actualHeight = originalImage.size.height
            var divBy : CGFloat
            var newWidth : CGFloat
            var newHeight : CGFloat
            if actualWidth > actualWidth {
                divBy = (actualWidth / resize)
                newWidth = resize
                newHeight = (actualHeight / divBy)
            } else {
                divBy = (actualHeight / resize)
                newHeight = resize
                newWidth = (actualWidth / divBy)
            }
            
            let rect = CGRectMake(0.0, 0.0, newWidth, newHeight)
            UIGraphicsBeginImageContext(rect.size)
            originalImage.drawInRect(rect)
            imgCurrentPhoto.image = UIGraphicsGetImageFromCurrentImageContext()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
