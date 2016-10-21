//
//  SavedReports.swift
//  ReCal
//
//  Created by Xiaomei Huang on 9/26/16.
//  Copyright © 2016 Xiaomei Huang. All rights reserved.
//

import UIKit
import Photos

class SavedReports: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var reportImgs = [UIImage]()
    var reportImg: UIImage?
    
    var mainPageVC: UIViewController!
    
    func toMain() {
        
        self.slideMenuController()?.changeMainViewController(self.mainPageVC, close: true)
    }

    
    override func viewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainPageVC = storyboard.instantiateViewControllerWithIdentifier("mainPage") as! MainPage
        self.mainPageVC = UINavigationController(rootViewController: mainPageVC)

        
        super.viewDidLoad()
        loadData()
        
        let done : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(SavedReports.toMain))
        
        self.navigationItem.rightBarButtonItems = [done]
        self.navigationItem.title = "Saved Reports"

        
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setPicNavigationBarItem()
        loadData()
    }
    
    func loadData(){
        self.reportImgs.removeAll()
        FetchCustomAlbumPhotos()
        
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionView.reloadData()
        })
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportImgs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("img", forIndexPath: indexPath) as! ImgCell
        
        cell.img.image = reportImgs[indexPath.row]
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("reportImg") as! SubContentsViewController
        self.navigationController?.pushViewController(subContentsVC, animated: true)
        subContentsVC.showImg = self.reportImgs[indexPath.row]
        
    }
    
    
    
    
    
    func FetchCustomAlbumPhotos()
    {
        let albumName = "RetireReport"
        var assetCollection = PHAssetCollection()
        var albumFound = Bool()
        var photoAssets = PHFetchResult()
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        
        if let _:AnyObject = collection.firstObject{
            //found the album
            assetCollection = collection.firstObject as! PHAssetCollection
            albumFound = true
        }
        else { albumFound = false }
        _ = collection.count
        photoAssets = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
        let imageManager = PHCachingImageManager()
        
        //        let imageManager = PHImageManager.defaultManager()
        
        photoAssets.enumerateObjectsUsingBlock{(object: AnyObject!,
            count: Int,
            stop: UnsafeMutablePointer<ObjCBool>) in
            
            if object is PHAsset{
                let asset = object as! PHAsset
                print("Inside  If object is PHAsset, This is number 1")
                
                let imageSize = CGSize(width: asset.pixelWidth,
                    height: asset.pixelHeight)
                
                /* For faster performance, and maybe degraded image */
                let options = PHImageRequestOptions()
                options.deliveryMode = .FastFormat
                options.synchronous = true
                
                imageManager.requestImageForAsset(asset,
                    targetSize: imageSize,
                    contentMode: .AspectFit,
                    options: options,
                    resultHandler: {
                        (image, info) -> Void in
                        self.reportImg = image!
                        /* The image is now available to us */
                        self.addImgToArray(self.reportImg!)
                        print("enum for image, This is number 2")
                        
                })
                
            }
        }
    }
    
    func addImgToArray(uploadImage:UIImage)
    {
        self.reportImgs.append(uploadImage)
        
    }
    


}
