//
//  MainPage.swift
//  ReCal
//
//  Created by Xiaomei Huang on 9/19/16.
//  Copyright © 2016 Xiaomei Huang. All rights reserved.
//

import UIKit

class MainPage: UIViewController {
    
    
    @IBAction func basicB(sender: AnyObject) {
        self.goToBasic()
    }
    
    @IBAction func goalB(sender: AnyObject) {
        self.goToGoal()
    }
    
    @IBAction func reportB(sender: AnyObject) {
        self.goToReport()
    }
    
    let rightVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("rightNote") as UIViewController
    
    var basicInfoVC: UIViewController!
    var goalVC: UIViewController!
    var reportVC: UIViewController!
    
    func goToBasic() {
        
        self.slideMenuController()?.changeMainViewController(self.basicInfoVC, close: true)
    }
    func goToGoal() {
        
        self.slideMenuController()?.changeMainViewController(self.goalVC, close: true)
    }
    func goToReport() {
        
        self.slideMenuController()?.changeMainViewController(self.reportVC, close: true)
    }

    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let basicInfoVC = storyboard.instantiateViewControllerWithIdentifier("basicInfo") as!BasicInfo
        
        self.basicInfoVC = UINavigationController(rootViewController: basicInfoVC)
        
        let goalVC = storyboard.instantiateViewControllerWithIdentifier("goal") as! Goal
        
        self.goalVC = UINavigationController(rootViewController: goalVC)
        
        
        let reportVC = storyboard.instantiateViewControllerWithIdentifier("report") as! ReportVC
        
        self.reportVC = UINavigationController(rootViewController: reportVC)

        
        self.slideMenuController()?.changeRightViewController(rightVC, closeRight: true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        
  //      self.slideMenuController()?.changeRightViewController(rightVC, closeRight: true)

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
