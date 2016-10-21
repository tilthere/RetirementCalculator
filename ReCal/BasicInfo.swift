//
//  BasicInfo.swift
//  ReCal
//
//  Created by Xiaomei Huang on 9/19/16.
//  Copyright © 2016 Xiaomei Huang. All rights reserved.
//

import UIKit
import Eureka

class BasicInfo : FormViewController {
    
    let userinfo = NSUserDefaults.standardUserDefaults()
    var mainPageVC: UIViewController!
    
    func backToMain() {
        
        self.slideMenuController()?.changeMainViewController(self.mainPageVC, close: true)
    }


 
    let basicFAQVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("basicFAQ") as UIViewController

    
    @IBAction func openLeft(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }

    
    @IBAction func openFAQ(sender: AnyObject) {

        self.slideMenuController()?.openRight()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.slideMenuController()?.changeRightViewController(basicFAQVC, closeRight: true)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainPageVC = storyboard.instantiateViewControllerWithIdentifier("mainPage") as! MainPage
        self.mainPageVC = UINavigationController(rootViewController: mainPageVC)
        
        //Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.center = CGPointMake(view.frame.width/2, view.frame.height-20)
        toolbar.backgroundColor = UIColor.clearColor()
        toolbar.tintColor = UIColor(red:0.06, green:0.34, blue:0.11, alpha:1.0)
        
        //Alight Left and Right
        let flexibleB = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)


        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(BasicInfo.backToMain))
        toolbar.items = [flexibleB, done]
        
        view.addSubview(toolbar)

        

        
        
        
        
        form
            
         +++ Section(header: "Your basic info", footer: "Next Please Enter Your Current Income, Notice That All Income Are Before Tax")
            
            <<< NameRow() {
                $0.title = "Name:"
                $0.placeholder = "(Xiaomei)"
                $0.value = userinfo.stringForKey("username")
                }.onChange{
                    if ($0.value != nil){
                        self.userinfo.setObject($0.value, forKey: "username")}
            }
        
            
            <<< DateRow() {
      //          $0.value = NSDate()
                $0.maximumDate = NSCalendar.currentCalendar().dateByAddingUnit(.Year, value: -18, toDate: NSDate(), options: [])
                $0.title = "Birthday:"
                $0.value = userinfo.objectForKey("birthday") as? NSDate
                }.onChange{
                    self.userinfo.setObject($0.value, forKey: "birthday")
            }
            
            <<< SegmentedRow<String>(){
                $0.title = "Gender:                              "
                $0.options = ["Male", "Female"]
                $0.value = userinfo.stringForKey("gender")
                
                }.onChange{
                    self.userinfo.setObject($0.value, forKey: "gender")
            }


         
            
            
            +++ Section("Your Current Income")
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Annual Income:"
                $0.value = userinfo.doubleForKey("annualIncome")
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                }.onChange{
                    if ($0.value != nil){
                    self.userinfo.setObject($0.value, forKey: "annualIncome")
                    }
            }

        
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Traditional Pension:"
                $0.value = userinfo.doubleForKey("pension")
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                }.onChange{
                    if ($0.value != nil){
                    self.userinfo.setObject($0.value, forKey: "pension")
                    }
            }
        
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Part-time Income:"
                $0.value = userinfo.doubleForKey("parttime")
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                }.onChange{
                    if ($0.value != nil){
                    self.userinfo.setObject($0.value, forKey: "parttime")
                    }
            }

            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Other Income:"
                $0.value = userinfo.doubleForKey("other")
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                }.onChange{
                    if ($0.value != nil){
                    self.userinfo.setObject($0.value, forKey: "other")
                    }
            }
            
            +++ Section("Your current savings, include money accumulated in 401(k),IRA or similar retirement plan")
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Current Saving:"
                $0.value = userinfo.doubleForKey("currentSaving")
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                }.onChange{
                    if ($0.value != nil){
                        self.userinfo.setObject($0.value, forKey: "currentSaving")
                    }
            }

            +++ Section(" "){
                $0.header?.height = {220}
                
            }
        
        }
    
    
    class CurrencyFormatter : NSNumberFormatter, FormatterProtocol {
        override func getObjectValue(obj: AutoreleasingUnsafeMutablePointer<AnyObject?>, forString string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>) -> Bool {
            guard obj != nil else { return false }
            let str = string.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
            obj.memory = NSNumber(double: (Double(str) ?? 0.0)/Double(pow(10.0, Double(minimumFractionDigits))))
            return true
        }
        
        func getNewPosition(forPosition position: UITextPosition, inTextInput textInput: UITextInput, oldValue: String?, newValue: String?) -> UITextPosition {
            return textInput.positionFromPosition(position, offset:((newValue?.characters.count ?? 0) - (oldValue?.characters.count ?? 0))) ?? position
        }
    }
}