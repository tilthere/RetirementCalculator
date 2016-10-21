//
//  Report.swift
//  ReCal
//
//  Created by Xiaomei Huang on 9/20/16.
//  Copyright © 2016 Xiaomei Huang. All rights reserved.
//

import UIKit
import Eureka
//import AssetsLibrary
import Photos
import Social


class ReportVC: FormViewController {
    
    let userinfo = NSUserDefaults.standardUserDefaults()
    var reportVC: UIViewController!
    var mainPageVC: UIViewController!
    
    
    
    @IBAction func openLeft(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }

    
    @IBAction func faqButton(sender: AnyObject) {
        
       screenShotMethod()
  
    }
    
    func screenShotMethod() {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenshotFull = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // crop 
        UIGraphicsBeginImageContext(view.frame.size)
 //       screenshotFull.drawAtPoint(CGPointMake(-1,-62))  //  2 to the right, 66 down
        screenshotFull.drawInRect(CGRectMake(1, -62, view.frame.width, view.frame.height+120))

        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
//        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
//        
        let ac = UIAlertController(title: "Report Saved", message: "Your report has been saved", preferredStyle: .Alert)
        func handler(act:UIAlertAction!) {
            print("User tapped \(act.title)")
        }
        ac.addAction(UIAlertAction(title: "OK", style:.Default, handler: handler))
        self.presentViewController(ac, animated: true, completion: nil)
        
        let imageData = UIImageJPEGRepresentation(screenshot, 1)
        let reportImage = UIImage(data: imageData!)
        
        
        PHPhotoLibrary.saveImage(reportImage!, albumName: "RetireReport") { asset in
            guard let asset = asset else {
                assert(false, "Asset is nil")
                return
            }
            PHPhotoLibrary.loadThumbnailFromAsset(asset) { thumbnail in
                print(thumbnail)
            }
        }
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let reportVC = storyboard.instantiateViewControllerWithIdentifier("report") as! ReportVC
        let mainPageVC = storyboard.instantiateViewControllerWithIdentifier("mainPage") as! MainPage
        self.mainPageVC = UINavigationController(rootViewController: mainPageVC)
        
        self.reportVC = UINavigationController(rootViewController: reportVC)
        
        let flexibleB = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        
        
        
        //Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.center = CGPointMake(view.frame.width/2, view.frame.height-20)
        toolbar.backgroundColor = UIColor.clearColor()
        toolbar.tintColor = UIColor(red:0.06, green:0.34, blue:0.11, alpha:1.0)
        
        //Alight Left and Right
        let share = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: #selector(reportVC.share))
        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(reportVC.backToMain))
        toolbar.items = [share, flexibleB, done]
        
        view.addSubview(toolbar)
        
        calResult()
        loadForm()
        
    }
    
    
    func changeViewController() {
 
        self.slideMenuController()?.changeMainViewController(self.reportVC, close: true)
    }
    
    func backToMain() {
        
        self.slideMenuController()?.changeMainViewController(self.mainPageVC, close: true)
    }

    
    
    func loadForm(){
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "MMM d, H:mm a"
        
        form
            
//            +++ Section()
//            
//            <<< NameRow() {
//                $0.title = ""
//                $0.value = " "
//                $0.cell.textField.userInteractionEnabled = false
//            }
            +++ Section("Report Time:  " + dateFormatter.stringFromDate(NSDate())){
                $0.header?.height = {110}
            }
            
            <<< NameRow() {
                $0.title = "Name:"
                $0.value = userinfo.stringForKey("username")
                $0.cell.textField.userInteractionEnabled = false
            }
            
            
            <<< IntRow() {
                $0.title = "Age"
                $0.value = userinfo.integerForKey("age")
                $0.cell.textField.userInteractionEnabled = false
                
            }
            
            <<< NameRow() {
                $0.title = "Gender:"
                $0.value = userinfo.stringForKey("gender")
                $0.cell.textField.userInteractionEnabled = false
            }
            
            <<< SwitchRow("switchRowTag"){
                $0.title = "Show Income detail"
                
            }
            
            
            <<< DecimalRow(){
                $0.hidden = Condition.Function(["switchRowTag"], { form in
                    return !((form.rowByTag("switchRowTag") as? SwitchRow)?.value ?? false) || (self.userinfo.doubleForKey("annualIncome") == 0.0)

                })
                $0.useFormatterDuringInput = true
                $0.title = "Annual Income:"
                $0.value = userinfo.doubleForKey("annualIncome")
                $0.cell.textField.userInteractionEnabled = false
                
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
            }
            
            <<< DecimalRow(){
                $0.hidden = Condition.Function(["switchRowTag"], { form in
                    return !((form.rowByTag("switchRowTag") as? SwitchRow)?.value ?? false) || (self.userinfo.doubleForKey("social") == 0.0)

                })
                $0.useFormatterDuringInput = true
                $0.title = "Social Security:"
                $0.value = userinfo.doubleForKey("social")
                $0.cell.textField.userInteractionEnabled = false
                
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
            }
            
            
            
            <<< DecimalRow(){
                $0.hidden = Condition.Function(["switchRowTag"], { form in
                    return !((form.rowByTag("switchRowTag") as? SwitchRow)?.value ?? false) || (self.userinfo.doubleForKey("pension") == 0.0)

                })
                $0.useFormatterDuringInput = true
                $0.title = "Traditional Pension:"
                $0.value = userinfo.doubleForKey("pension")
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                $0.cell.textField.userInteractionEnabled = false
            }
            
            <<< DecimalRow(){
                $0.hidden = Condition.Function(["switchRowTag"], { form in
                    return !((form.rowByTag("switchRowTag") as? SwitchRow)?.value ?? false) || (self.userinfo.doubleForKey("parttime") == 0.0)

                })
                $0.useFormatterDuringInput = true
                $0.title = "Part-time Income:"
                $0.value = userinfo.doubleForKey("parttime")
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                $0.cell.textField.userInteractionEnabled = false
            }
            
            <<< DecimalRow(){
                $0.hidden = Condition.Function(["switchRowTag"], { form in
                    return !((form.rowByTag("switchRowTag") as? SwitchRow)?.value ?? false) || (self.userinfo.doubleForKey("other") == 0.0)

                })
                $0.useFormatterDuringInput = true
                $0.title = "Other Income:"
                $0.value = userinfo.doubleForKey("other")
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                $0.cell.textField.userInteractionEnabled = false
            }
            
            <<< DecimalRow(){
                $0.hidden = Condition.Function(["switchRowTag"], { form in
                    return !((form.rowByTag("switchRowTag") as? SwitchRow)?.value ?? false) || (self.userinfo.doubleForKey("currentSaving") == 0.0)
                })
                $0.useFormatterDuringInput = true
                $0.title = "Savings:"
                $0.value = userinfo.doubleForKey("currentSaving")
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                $0.cell.textField.userInteractionEnabled = false
            }
            
            +++ Section("Your expectation for retirement: "){
                $0.header?.height = {20}
            }


            
            <<< StepperRowInt() {
                $0.title = "Expected Retire Age:"
                $0.value = userinfo.integerForKey("expAge")
                 
            }.onChange { row in
                let new = row.value!
                self.userinfo.setObject(new, forKey: "expAge")
                self.changeViewController()
            }
            
            

            <<< StepperRow() {
                $0.title = "Expected annual Income(%):"
                $0.value = userinfo.doubleForKey("percentage")
                
                }.onChange { row in
                    let new = row.value!
                    self.userinfo.setObject(new, forKey: "percentage")
                    let amount = self.userinfo.doubleForKey("percentage") * self.userinfo.doubleForKey("annualIncome")/100
                    self.userinfo.setObject(amount, forKey: "amount")
                    self.changeViewController()
            }
            
            
 
            
            
            //       +++ Section()
            
            <<< SegmentedRow<String>("segments"){
                $0.options = [ "Annual", "Monthly"]
                $0.value = "Annual"
            }
            +++ Section(" "){
                $0.tag = "Annual"
                $0.hidden = "$segments != 'Annual'"
                $0.header?.height = { CGFloat.min }
              //  $0.header?.height = {0.5}


            }
            
            
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Expected annual income:"
                $0.value = userinfo.doubleForKey("expAnnualIncome")
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                $0.cell.textField.userInteractionEnabled = false
         //       $0.cell.textField.textColor = UIColor.redColor()
                }.cellUpdate{cell, row in
                    cell.textLabel?.textColor = UIColor.redColor()
                    cell.textField.textColor = UIColor.redColor()
            }
            
            
            
            
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Amount to save annually:"
                if (userinfo.doubleForKey("stepSix") > 0){
                    $0.value = userinfo.doubleForKey("stepSix")
                } else {
                    $0.value = 0
                }
                
                
                
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                $0.cell.textField.userInteractionEnabled = false
                }.cellUpdate{cell, row in
                    cell.textLabel?.textColor = UIColor.redColor()
                    cell.textField.textColor = UIColor.redColor()
            }
            
            
            +++ Section(" "){
                $0.tag = "Monthly"
                $0.hidden = "$segments != 'Monthly'"
                $0.header?.height = { CGFloat.min }
               // $0.header?.height = {0.5}


            }
            
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Expected monthly income:"
                $0.value = userinfo.doubleForKey("expMonthlyIncome")
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                $0.cell.textField.userInteractionEnabled = false
                
                }.cellUpdate{cell, row in
                    cell.textLabel?.textColor = UIColor.redColor()
                    cell.textField.textColor = UIColor.redColor()
            }
            
            
            
            
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Amount to save monthly:"
                
                if (userinfo.doubleForKey("monthlyToSave") > 0){
                    $0.value = userinfo.doubleForKey("monthlyToSave")
                } else {
                    $0.value = 0
                }
                
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
                $0.cell.textField.userInteractionEnabled = false
                }.cellUpdate{cell, row in
                    cell.textLabel?.textColor = UIColor.redColor()
                    cell.textField.textColor = UIColor.redColor()
            }
            
            
        
            +++ Section(" "){
                $0.header?.height = {180}
            }

//            <<< ButtonRow() { (row: ButtonRow) -> Void in
//                row.title = "SHARE"
//                }  .onCellSelection({ (cell, row) in
//                    self.share()
//                }).cellUpdate{cell, row in
//                    cell.textLabel?.textColor = UIColor(red:0.06, green:0.34, blue:0.11, alpha:1.0)
//            }
//            
//            +++ Section(" "){
//                $0.header?.height = {5}
//            }
//
//            <<< ButtonRow() { (row: ButtonRow) -> Void in
//                row.title = "DONE"
//                
//                }  .onCellSelection({ (cell, row) in
//                    print("click")
//                    self.backToMain()
//                    
//                }) .cellUpdate{cell, row in
//                    cell.textLabel?.textColor = UIColor(red:0.06, green:0.34, blue:0.11, alpha:1.0)
//                }


    }
    
    func getStepFive(){
        if ((userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) <= 10) {
            let stepFive = userinfo.doubleForKey("currentSaving") * 1.3
            userinfo.setObject(stepFive, forKey: "stepFive")
        } else if ((userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) > 10 && (userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) <= 15) {
            let stepFive = userinfo.doubleForKey("currentSaving") * 1.6
            userinfo.setObject(stepFive, forKey: "stepFive")
        } else if ((userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) > 15 && (userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) <= 20) {
            let stepFive = userinfo.doubleForKey("currentSaving") * 1.8
            userinfo.setObject(stepFive, forKey: "stepFive")
        } else if ((userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) > 20 && (userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) <= 25) {
            let stepFive = userinfo.doubleForKey("currentSaving") * 2.1
            userinfo.setObject(stepFive, forKey: "stepFive")
        } else if ((userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) > 25 && (userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) <= 30) {
            let stepFive = userinfo.doubleForKey("currentSaving") * 2.4
            userinfo.setObject(stepFive, forKey: "stepFive")
        } else if ((userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) > 30 && (userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) <= 35) {
            let stepFive = userinfo.doubleForKey("currentSaving") * 2.8
            userinfo.setObject(stepFive, forKey: "stepFive")
        } else  {
            let stepFive = userinfo.doubleForKey("currentSaving") * 3.3
            userinfo.setObject(stepFive, forKey: "stepFive")
        }
        
    }
    
    func getStepSix(){
        if ((userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) <= 10) {
            let stepSix = userinfo.doubleForKey("totalNeedSaving") * 0.085
            userinfo.setObject(stepSix, forKey: "stepSix")
        } else if ((userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) > 10 && (userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) <= 15) {
            let stepSix = userinfo.doubleForKey("totalNeedSaving") * 0.052
            userinfo.setObject(stepSix, forKey: "stepSix")
        } else if ((userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) > 15 && (userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) <= 20) {
            let stepSix = userinfo.doubleForKey("totalNeedSaving") * 0.036
            userinfo.setObject(stepSix, forKey: "stepSix")
        } else if ((userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) > 20 && (userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) <= 25) {
            let stepSix = userinfo.doubleForKey("totalNeedSaving") * 0.027
            userinfo.setObject(stepSix, forKey: "stepSix")
        } else if ((userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) > 25 && (userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) <= 30) {
            let stepSix = userinfo.doubleForKey("totalNeedSaving") * 0.020
            userinfo.setObject(stepSix, forKey: "stepSix")
        } else if ((userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) > 30 && (userinfo.integerForKey("expAge") - userinfo.integerForKey("age")) <= 35) {
            let stepSix = userinfo.doubleForKey("totalNeedSaving") * 0.016
            userinfo.setObject(stepSix, forKey: "stepSix")
        } else  {
            let stepSix = userinfo.doubleForKey("totalNeedSaving") * 0.013
            userinfo.setObject(stepSix, forKey: "stepSix")
        }
        
    }

    
    
    
    
    
    
    
    func getFator() {
        if (userinfo.stringForKey("gender") == "Male"){
            if (userinfo.integerForKey("expAge") >= 55 && userinfo.integerForKey("expAge") < 60){
                if(userinfo.integerForKey("expYear") >= 80 && userinfo.integerForKey("expAge") < 89){
                    userinfo.setObject(18.79, forKey: "fator")
                } else if(userinfo.integerForKey("expYear") >= 89 && userinfo.integerForKey("expAge") < 94){
                    userinfo.setObject(21.71, forKey: "fator")
                } else {
                    userinfo.setObject(23.46, forKey: "fator")
                }
            } else if (userinfo.integerForKey("expAge") >= 60 && userinfo.integerForKey("expAge") < 65){
                if(userinfo.integerForKey("expYear") >= 80 && userinfo.integerForKey("expAge") < 89){
                    userinfo.setObject(16.31, forKey: "fator")
                } else if(userinfo.integerForKey("expYear") >= 89 && userinfo.integerForKey("expAge") < 94){
                    userinfo.setObject(19.68, forKey: "fator")
                } else {
                    userinfo.setObject(21.71, forKey: "fator")
                }
            } else if (userinfo.integerForKey("expAge") >= 65 && userinfo.integerForKey("expAge") < 70){
                if(userinfo.integerForKey("expYear") >= 80 && userinfo.integerForKey("expAge") < 89){
                    userinfo.setObject(13.45, forKey: "fator")
                } else if(userinfo.integerForKey("expYear") >= 89 && userinfo.integerForKey("expAge") < 94){
                    userinfo.setObject(17.35, forKey: "fator")
                } else {
                    userinfo.setObject(19.68, forKey: "fator")
                }
            } else {
                if(userinfo.integerForKey("expYear") >= 80 && userinfo.integerForKey("expAge") < 89){
                    userinfo.setObject(10.15, forKey: "fator")
                } else if(userinfo.integerForKey("expYear") >= 89 && userinfo.integerForKey("expAge") < 94){
                    userinfo.setObject(14.65, forKey: "fator")
                } else {
                    userinfo.setObject(17.35, forKey: "fator")
                }
            }
        } else {
            if (userinfo.integerForKey("expAge") >= 55 && userinfo.integerForKey("expAge") < 60){
                if(userinfo.integerForKey("expYear") >= 80 && userinfo.integerForKey("expAge") < 92){
                    userinfo.setObject(20.53, forKey: "fator")
                } else if(userinfo.integerForKey("expYear") >= 92 && userinfo.integerForKey("expAge") < 97){
                    userinfo.setObject(22.79, forKey: "fator")
                } else {
                    userinfo.setObject(24.40, forKey: "fator")
                }
            } else if (userinfo.integerForKey("expAge") >= 60 && userinfo.integerForKey("expAge") < 65){
                if(userinfo.integerForKey("expYear") >= 80 && userinfo.integerForKey("expAge") < 92){
                    userinfo.setObject(18.32, forKey: "fator")
                } else if(userinfo.integerForKey("expYear") >= 92 && userinfo.integerForKey("expAge") < 97){
                    userinfo.setObject(20.93, forKey: "fator")
                } else {
                    userinfo.setObject(22.79, forKey: "fator")
                }
            } else if (userinfo.integerForKey("expAge") >= 65 && userinfo.integerForKey("expAge") < 70){
                if(userinfo.integerForKey("expYear") >= 80 && userinfo.integerForKey("expAge") < 92){
                    userinfo.setObject(15.77, forKey: "fator")
                } else if(userinfo.integerForKey("expYear") >= 92 && userinfo.integerForKey("expAge") < 97){
                    userinfo.setObject(18.79, forKey: "fator")
                } else {
                    userinfo.setObject(20.93, forKey: "fator")
                }
            } else {
                if(userinfo.integerForKey("expYear") >= 80 && userinfo.integerForKey("expAge") < 92){
                    userinfo.setObject(12.83, forKey: "fator")
                } else if(userinfo.integerForKey("expYear") >= 92 && userinfo.integerForKey("expAge") < 97){
                    userinfo.setObject(16.31, forKey: "fator")
                } else {
                    userinfo.setObject(18.79, forKey: "fator")
                }
            }
            
        }
    }
    
    func calResult(){
        if let dob = userinfo.objectForKey("birthday") as? NSDate{
            
            let age = dob.age
            self.userinfo.setObject(age, forKey: "age")
            
        }
        
        let ann = userinfo.doubleForKey("annualIncome")
        if (ann < 25000){
            self.userinfo.setObject(8000, forKey: "social")
        } else if (ann > 40000){
            self.userinfo.setObject(14500, forKey: "social")
        } else {
            self.userinfo.setObject(12000, forKey: "social")
        }
        
        let makeup = userinfo.doubleForKey("amount") - userinfo.doubleForKey("social") - userinfo.doubleForKey("pension") - userinfo.doubleForKey("parttime") - userinfo.doubleForKey("other")
        userinfo.setObject(makeup, forKey: "makeup")
        
        getFator()
        
        let stepThree = userinfo.doubleForKey("fator") * userinfo.doubleForKey("makeup")
        userinfo.setObject(stepThree, forKey: "stepThree")
        
        if (userinfo.integerForKey("expAge") < 65) {
            if (userinfo.integerForKey("expAge") > 60){
                let stepFour = 4.7 * userinfo.doubleForKey("social")
                userinfo.setObject(stepFour, forKey: "stepFour")
            } else {
                let stepFour = 8.8 * userinfo.doubleForKey("social")
                userinfo.setObject(stepFour, forKey: "stepFour")
            }
        } else {
            userinfo.setObject(0.0, forKey: "stepFour")
        }
        
        getStepFive()
        let totalNeedSaving = userinfo.doubleForKey("stepThree") + userinfo.doubleForKey("stepFour") - userinfo.doubleForKey("stepFive")
        
        userinfo.setObject(totalNeedSaving, forKey: "totalNeedSaving")
        getStepSix()
        
        let annualToSave = userinfo.doubleForKey("stepSix")
        let monthlyToSave = annualToSave / 12
        userinfo.setObject(monthlyToSave, forKey: "monthlyToSave")

        let expAnnualIncome = userinfo.doubleForKey("amount")
        userinfo.setObject(expAnnualIncome, forKey: "expAnnualIncome")
        userinfo.setObject(expAnnualIncome / 12, forKey: "expMonthlyIncome")


    }
    
    func share()
    {
        
        let defaultText = "I need to save \(userinfo.doubleForKey("stepSix")) per year from now if I want to retire at age \(userinfo.integerForKey("expAge")) with expected annual income of $\(userinfo.doubleForKey("expAnnualIncome")). "
        
        
        let activityViewController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
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