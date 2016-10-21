//
//  styleBtn.swift
//  MSFW
//
//  Created by Xiaomei Huang on 6/11/16.
//  Copyright © 2016 Xiaomei Huang. All rights reserved.
//

import Foundation
import UIKit

class greenBtn: UIButton{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 8.0;
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 1.2
   //     self.backgroundColor =  UIColor(red:0.22, green:0.42, blue:0.14 ,alpha:1.0)
        self.backgroundColor = UIColor.whiteColor()
        self.tintColor = UIColor.whiteColor()
        
    }
    
}

class radiusButton:UIButton{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 15.0;
        
    }
    
}




class orangeBtn: UIButton{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 8.0;
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 1.2
        self.backgroundColor =  UIColor(red:0.89, green:0.55, blue:0.05 ,alpha:1.0)
        self.tintColor = UIColor.whiteColor()
        
    }
    
}




class ProfileBtn: UIButton{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor(red:0.42, green:0.76, blue:0.31 ,alpha:1.0).CGColor
        self.layer.borderWidth = 0.5
        self.backgroundColor =  UIColor(red:0.40, green:0.63, blue:0.29 ,alpha:1.0)
        self.tintColor = UIColor.whiteColor()
        let buttonImage = UIImage(named: "profile")
        
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.setImage(buttonImage, forState: .Normal)
        self.imageEdgeInsets = UIEdgeInsets(top: -15, left: 40, bottom: 10, right: 0)
        
        self.titleEdgeInsets = UIEdgeInsets(top: 20, left: -75, bottom: -30, right: 0)
    }
}
class MyAgencyBtn: UIButton{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor(red:0.42, green:0.76, blue:0.31 ,alpha:1.0).CGColor
        self.layer.borderWidth = 0.5
        self.backgroundColor =  UIColor(red:0.47, green:0.80, blue:0.33 ,alpha:1.0)
        self.tintColor = UIColor.whiteColor()
        let buttonImage = UIImage(named: "myagency")
        
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.setImage(buttonImage, forState: .Normal)
        self.imageEdgeInsets = UIEdgeInsets(top: -15, left: 60, bottom: 10, right: 0)
        
        self.titleEdgeInsets = UIEdgeInsets(top: 20, left: -65, bottom: -30, right: 0)
    }
}

class MyJobBtn: UIButton{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor(red:0.42, green:0.76, blue:0.31 ,alpha:1.0).CGColor
        self.layer.borderWidth = 0.5
        self.backgroundColor =  UIColor(red:0.40, green:0.68, blue:0.29 ,alpha:1.0)
        self.tintColor = UIColor.whiteColor()
        let buttonImage = UIImage(named: "myjob")
        
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.setImage(buttonImage, forState: .Normal)
        self.imageEdgeInsets = UIEdgeInsets(top: -15, left: 50, bottom: 10, right: 0)
        
        self.titleEdgeInsets = UIEdgeInsets(top: 30, left: -75, bottom: -30, right: 0)    }
}

class MyPostBtn: UIButton{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor(red:0.42, green:0.76, blue:0.31 ,alpha:1.0).CGColor
        self.layer.borderWidth = 0.5
        self.backgroundColor =  UIColor(red:0.34, green:0.58, blue:0.24 ,alpha:1.0)
        self.tintColor = UIColor.whiteColor()
        let buttonImage = UIImage(named: "mypost")
        
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.setImage(buttonImage, forState: .Normal)
        self.imageEdgeInsets = UIEdgeInsets(top: -15, left: 55, bottom: 10, right: 0)
        
        self.titleEdgeInsets = UIEdgeInsets(top: 30, left: -75, bottom: -30, right: 0)
    }
}

class MyNoteBtn: UIButton{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor(red:0.42, green:0.76, blue:0.31 ,alpha:1.0).CGColor
        self.layer.borderWidth = 0.5
        self.backgroundColor =  UIColor(red:0.31, green:0.50, blue:0.22 ,alpha:1.0)
        self.tintColor = UIColor.whiteColor()
        let buttonImage = UIImage(named: "tool")
        
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.setImage(buttonImage, forState: .Normal)
        self.imageEdgeInsets = UIEdgeInsets(top: -15, left: 55, bottom: 10, right: 0)
        
        self.titleEdgeInsets = UIEdgeInsets(top: 35, left: -75, bottom: -30, right: 0)
    }
}

class NotificationBtn: UIButton{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor(red:0.42, green:0.76, blue:0.31 ,alpha:1.0).CGColor
        self.layer.borderWidth = 0.5
        self.backgroundColor =  UIColor(red:0.42, green:0.66, blue:0.31 ,alpha:1.0)
        self.tintColor = UIColor.whiteColor()
        let buttonImage = UIImage(named: "notification")
        
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.setImage(buttonImage, forState: .Normal)
        self.imageEdgeInsets = UIEdgeInsets(top: -15, left: 50, bottom: 10, right: 0)
        
        self.titleEdgeInsets = UIEdgeInsets(top: 35, left: -75, bottom: -30, right: 0)
    }
    
    
    
}

    
//    func setupButton(button: UIButton) {
//        let spacing: CGFloat = 6.0
//        let imageSize: CGSize = button.imageView!.image!.size
//        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0)
//        let labelString = NSString(string: button.titleLabel!.text!)
//        let titleSize = labelString.sizeWithAttributes([NSFontAttributeName: button.titleLabel!.font])
//        button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
//        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
//        button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0)
//    }
    


