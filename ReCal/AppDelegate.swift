//
//  AppDelegate.swift
//  ReCal
//
//  Created by Xiaomei Huang on 9/19/16.
//  Copyright © 2016 Xiaomei Huang. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        let userinfo = NSUserDefaults.standardUserDefaults()
        if ((userinfo.objectForKey("username")) == nil){
            userinfo.setObject("", forKey: "username")
        }
        if ((userinfo.objectForKey("birthday")) == nil){
            userinfo.setObject(NSCalendar.currentCalendar().dateByAddingUnit(.Year, value: -18, toDate: NSDate(), options: []), forKey: "birthday")
        }
        if ((userinfo.objectForKey("gender")) == nil){
            userinfo.setObject("Male", forKey: "gender")
        }
        if ((userinfo.objectForKey("annualIncome")) == nil){
            userinfo.setObject(0, forKey: "annualIncome")
        }
        if ((userinfo.objectForKey("pension")) == nil){
            userinfo.setObject(0, forKey: "pension")
        }
        if ((userinfo.objectForKey("parttime")) == nil){
            userinfo.setObject(0, forKey: "parttime")
        }
        if ((userinfo.objectForKey("other")) == nil){
            userinfo.setObject(0, forKey: "other")
        }
        
//        if ((userinfo.objectForKey("percentage")) == nil && (userinfo.objectForKey("amount")) == nil ){
//            userinfo.setObject(70, forKey: "percentage")
//        }
        if ((userinfo.objectForKey("percentage")) == nil ){
            userinfo.setObject(70, forKey: "percentage")
        }

        
        if ((userinfo.objectForKey("byWhich")) == nil){
            userinfo.setObject("ByPercentage", forKey: "byWhich")
        }
        
        if ((userinfo.objectForKey("expYear")) == nil){
            userinfo.setObject(85, forKey: "expYear")
        }
        
        if ((userinfo.objectForKey("expAge")) == nil){
            userinfo.setObject(65, forKey: "expAge")
        }
        
        if ((userinfo.objectForKey("currentSaving")) == nil){
            userinfo.setObject(0, forKey: "currentSaving")
        }


        
        
  
        
         let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        UINavigationBar.appearance().barTintColor = UIColor(red:0.06, green:0.34, blue:0.11, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        

        
        // create viewController code...
        let leftVC = storyBoard.instantiateViewControllerWithIdentifier("leftMenu") as! LeftMenu
        
        let rightVC = storyBoard.instantiateViewControllerWithIdentifier("rightNote") as! RightNote
        
        
        let mainVC = storyBoard.instantiateViewControllerWithIdentifier("mainPage") as! MainPage
        
        let nvc = UINavigationController(rootViewController: mainVC)
        
        leftVC.mainPageVC = nvc
        
      
        
        
        let slideMenuController = ExSlideMenuController(mainViewController: nvc, leftMenuViewController: leftVC, rightMenuViewController: rightVC)
  
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

