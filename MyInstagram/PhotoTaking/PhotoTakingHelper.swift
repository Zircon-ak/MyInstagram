//
//  PhotoTakingHelper.swift
//  MyInstagram
//
//  Created by Paethai Akarajariyakul on 3/24/16.
//  Copyright © 2016 mycompany. All rights reserved.
//

import UIKit

typealias PhotoTakingHelperCallback = UIImage? -> Void

class PhotoTakingHelper: NSObject {
    //1. Present action sheet --> UIAlertController
    //2. Present the camera or photo library -->UIImagePickerController
    //3. Return the image --> Callback function
    
    weak var viewController: UIViewController!
    var callback: PhotoTakingHelperCallback
    var imagePickerController: UIImagePickerController?
    
    init(viewController: UIViewController, callback: PhotoTakingHelperCallback){
        self.viewController = viewController
        self.callback = callback
        
        super.init()
        showPhotoSourceSelection()
    }
    
    func showImagePickerController( sourceType: UIImagePickerControllerSourceType ) {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        imagePickerController?.delegate = self
        self.viewController.presentViewController(imagePickerController!, animated: true, completion: nil)
    }
    
    func showPhotoSourceSelection(){
        // Allow user to choose between photo library and camera
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photo from Library", style: .Default) { (action) in
            self.showImagePickerController(.PhotoLibrary)
        }
        
        alertController.addAction(photoLibraryAction)
        
        //Only show camera option if rear camera is available
        if(UIImagePickerController.isCameraDeviceAvailable(.Rear)) {
            let cameraAction = UIAlertAction(title: "Photo from Camera", style: .Default){ (action) in
                self.showImagePickerController(.Camera)
            }
            alertController.addAction(cameraAction)
        }
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
}

extension PhotoTakingHelper : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        viewController.dismissViewControllerAnimated(false, completion: nil)
        callback(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}




