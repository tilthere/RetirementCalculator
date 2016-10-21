//
//  ImgCell.swift
//  ReCal
//
//  Created by Xiaomei Huang on 9/27/16.
//  Copyright © 2016 Xiaomei Huang. All rights reserved.
//

import UIKit
import Photos

class ImgCell: UICollectionViewCell {
    
//    var reportImgs = [UIImage]()
//    var reportImg: UIImage?
    
    @IBOutlet weak var img: UIImageView!
    
//    func FetchCustomAlbumPhotos()
//    {
//        let albumName = "RetireReport"
//        var assetCollection = PHAssetCollection()
//        var albumFound = Bool()
//        var photoAssets = PHFetchResult()
//        
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
//        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
//        
//        if let _:AnyObject = collection.firstObject{
//            //found the album
//            assetCollection = collection.firstObject as! PHAssetCollection
//            albumFound = true
//        }
//        else { albumFound = false }
//        _ = collection.count
//        photoAssets = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
//        let imageManager = PHCachingImageManager()
//        
//        //        let imageManager = PHImageManager.defaultManager()
//        
//        photoAssets.enumerateObjectsUsingBlock{(object: AnyObject!,
//            count: Int,
//            stop: UnsafeMutablePointer<ObjCBool>) in
//            
//            if object is PHAsset{
//                let asset = object as! PHAsset
//                print("Inside  If object is PHAsset, This is number 1")
//                
//                let imageSize = CGSize(width: asset.pixelWidth,
//                    height: asset.pixelHeight)
//                
//                /* For faster performance, and maybe degraded image */
//                let options = PHImageRequestOptions()
//                options.deliveryMode = .FastFormat
//                options.synchronous = true
//                
//                imageManager.requestImageForAsset(asset,
//                    targetSize: imageSize,
//                    contentMode: .AspectFill,
//                    options: options,
//                    resultHandler: {
//                        (image, info) -> Void in
//                        self.reportImg = image!
//                        /* The image is now available to us */
//                        self.addImgToArray(self.reportImg!)
//                        print("enum for image, This is number 2")
//                        
//                })
//                
//            }
//        }
//    }
//    
//    func addImgToArray(uploadImage:UIImage)
//    {
//        self.reportImgs.append(uploadImage)
//        
//    }
//
//    
    
}
