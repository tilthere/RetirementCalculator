//
//  Goal.swift
//  ReCal
//
//  Created by Xiaomei Huang on 9/19/16.
//  Copyright © 2016 Xiaomei Huang. All rights reserved.
//

import UIKit
import Eureka

class Goal: FormViewController {
    
    let userinfo = NSUserDefaults.standardUserDefaults()
    var goalVC: UIViewController!
    
    var mainPageVC: UIViewController!
    
    func backToMain() {
        
        self.slideMenuController()?.changeMainViewController(self.mainPageVC, close: true)
    }
    
    func changeViewController() {
        
        self.slideMenuController()?.changeMainViewController(self.goalVC, close: true)
        
    }
    
    

    
    let goalFAQVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("goalFAQ") as UIViewController


    @IBAction func faqButton(sender: AnyObject) {
        self.slideMenuController()?.openRight()
    }
    
    
    @IBAction func openLeft(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let mainPageVC = storyboard.instantiateViewControllerWithIdentifier("mainPage") as! MainPage
        self.mainPageVC = UINavigationController(rootViewController: mainPageVC)
        

        
        let goalVC = storyboard.instantiateViewControllerWithIdentifier("goal") as! Goal
        
        self.goalVC = UINavigationController(rootViewController: goalVC)

        
        self.slideMenuController()?.changeRightViewController(goalFAQVC, closeRight: true)
        
        // calculate expected amount
        let amount = userinfo.doubleForKey("percentage") * userinfo.doubleForKey("annualIncome")/100
        userinfo.setObject(amount, forKey: "amount")
        
        //Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.center = CGPointMake(view.frame.width/2, view.frame.height-20)
        toolbar.backgroundColor = UIColor.clearColor()
        toolbar.tintColor = UIColor(red:0.06, green:0.34, blue:0.11, alpha:1.0)
        
        //Alight Left and Right
        let flexibleB = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        
        
        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(goalVC.backToMain))
        toolbar.items = [flexibleB, done]
        
        view.addSubview(toolbar)

        
        
        form
            
            +++ Section(header: "How much annual income will you want in retirement?", footer: "")
            
//            <<< SegmentedRow<String>("segments"){
//                $0.options = [ "ByPercentage", "ByAmount"]
//                $0.value = userinfo.stringForKey("byWhich")
//                }.onChange{
//                    self.userinfo.setObject($0.value, forKey: "byWhich")}
//                    
//            
//
//            
//            +++ Section(){
//                $0.tag = "percentage"
//                $0.hidden = "$segments != 'ByPercentage'"
//            }
            <<< SliderRow() {
                $0.title = "% of the current income "
                $0.value = userinfo.floatForKey("percentage")
                $0.cell.userInteractionEnabled = false
            }
            
            <<< StepperRow() {
           //     $0.title = "Expected Retire Income:(%)"
                $0.value = userinfo.doubleForKey("percentage")
                
                }.onChange { row in
                    let new = row.value!
                    self.userinfo.setObject(new, forKey: "percentage")
                    self.changeViewController()
                }
            

            

            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Expected Annual Amount:"
                $0.value = userinfo.doubleForKey("amount")
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                 $0.cell.textField.userInteractionEnabled = false
                }
            
            
            
            
            +++ Section(header: "At what age will you want to retire?", footer: "")
            
            
            <<< PickerInlineRow<Int>("Expected Retire Age:") { (row : PickerInlineRow<Int>) -> Void in
                row.title = row.tag
                row.displayValueFor = {
                    let age = $0
                    self.userinfo.setObject($0, forKey: "expAge")
                    return "\(age!)"}
                
                
                row.options = []
                for age in 55...70{
                    row.options.append(age)
                }
                row.value = userinfo.integerForKey("expAge")
            }
            
            +++ Section(header: "What age would you like to live to?", footer: "")
            
            
            <<< PickerInlineRow<Int>("Expected year:") { (row : PickerInlineRow<Int>) -> Void in
                row.title = row.tag
                row.displayValueFor = {
                    let year = $0
                    self.userinfo.setObject($0, forKey: "expYear")
                    
                    return "\(year!)"}
                
                
                row.options = []
                for year in 55...100{
                    row.options.append(year)
                }
                row.value = userinfo.integerForKey("expYear")
            }
            
            
            +++ Section(" "){
                $0.header?.height = { 160 }
        }
        
//            <<< ButtonRow() { (row: ButtonRow) -> Void in
//                row.title = "DONE"
//                }  .onCellSelection({ (cell, row) in
//                
//                  self.backToMain()
//                
//                }) .cellUpdate{cell, row in
//                    cell.textLabel?.textColor = UIColor(red:0.06, green:0.34, blue:0.11, alpha:1.0)
//                    
//        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
     //   self.slideMenuController()?.changeRightViewController(goalFAQVC, closeRight: true)
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
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