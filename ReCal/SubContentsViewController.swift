//
//  SubContentsViewController.swift
//  ReCal
//
//  Created by Xiaomei Huang on 9/27/16.
//  Copyright © 2016 Xiaomei Huang. All rights reserved.
//

import UIKit
import Social
import Photos

class SubContentsViewController: UIViewController {
    
    var userInfo = NSUserDefaults.standardUserDefaults()
    
    
    var showImg = UIImage()
    
    @IBOutlet weak var fullImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullImg.image = showImg
        
//        let safari : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: #selector(SubContentsViewController.share))
//        
//        self.navigationItem.rightBarButtonItems = [safari]
        
  //      self.navigationController?.toolbarHidden = false
  //      var items = [UIBarButtonItem]()
        let flexibleB = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)


        
        //Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.center = CGPointMake(view.frame.width/2, view.frame.height-20)
        toolbar.backgroundColor = UIColor.clearColor()
        toolbar.tintColor = UIColor(red:0.06, green:0.34, blue:0.11, alpha:1.0)
        
        //Alight Left and Right
        let share = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: #selector(SubContentsViewController.share))
        let trash = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action:nil)
        toolbar.items = [share, flexibleB, trash]
        
        view.addSubview(toolbar)
        
    }
    
    func share()
    {

        let img = self.showImg
        
        let activityViewController = UIActivityViewController(activityItems: [img], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
//    func trash(){
//        let alert = UIAlertController(title: "Delete Image", message: "Are you sure you want to delete this report?", preferredStyle: .Alert)
//        alert.addAction(UIAlertAction(title: "Yes", style: .Default,
//            handler: {(alertAction)in
//                
//                var index: Int = 0
//                let albumName = "RetireReport"
//                var assetCollection = PHAssetCollection()
//                var albumFound = Bool()
//                var photoAssets = PHFetchResult()
//                let fetchOptions = PHFetchOptions()
//                fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
//                let collection:PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
//                
//                if let _:AnyObject = collection.firstObject{
//                    //found the album
//                    assetCollection = collection.firstObject as! PHAssetCollection
//                    albumFound = true
//                }
//                else { albumFound = false }
//                _ = collection.count
//                photoAssets = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
//                let imageManager = PHCachingImageManager()
//                
//                
//                
//                PHPhotoLibrary.sharedPhotoLibrary().performChanges({
//                    //Delete Photo
//                    if let request = PHAssetCollectionChangeRequest(forAssetCollection: assetCollection){
//                        request.removeAssets([self.showImg])
//                    }
//                    },
//                    completionHandler: {(success, error)in
//                        NSLog("\nDeleted Image -> %@", (success ? "Success":"Error!"))
//                        alert.dismissViewControllerAnimated(true, completion: nil)
//                        if(success){
//                            // Move to the main thread to execute
//                            dispatch_async(dispatch_get_main_queue(), {
//                              let photosAsset = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
//                                if(photosAsset.count == 0){
//                                    print("No Images Left!!")
//                                    self.navigationController?.popToRootViewControllerAnimated(true)
//                                }else{
//                                    if(index >= photosAsset.count){
//                                        index = photosAsset.count - 1
//                                    }
//                                    self.reloadData()
//                                }
//                            })
//                        }else{
//                            print("Error: \(error)")
//                        }
//                })
//        }))
//        
//        alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: {(alertAction)in
//            //Do not delete photo
//            alert.dismissViewControllerAnimated(true, completion: nil)
//        }))
//        
//        self.presentViewController(alert, animated: true, completion: nil)
//    }
//    
//    func reloadData(){
//        print("delete")
//    }



}
