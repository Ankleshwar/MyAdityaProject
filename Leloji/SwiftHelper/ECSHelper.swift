//
//  ECSHelper.swift
//  DMS
//
//  Created by Shreesh Garg on 01/12/16.
//  Copyright © 2016 Shreesh Garg. All rights reserved.
//

import UIKit

import Toast_Swift
import ObjectMapper


class ECSHelper: NSObject {
    
    
//    open func setRootController(_ controller:UIViewController)
//    {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        var arrayController:Array = (appDelegate.navigationController?.viewControllers)!
//        arrayController.removeAll();
//        arrayController.append(controller)
//        appDelegate.navigationController?.viewControllers = arrayController;
//        
//        
//    }
    
   
    
    
}



class ECSAlert: NSObject {
    
    
    
    
    
    func showAlert(message:String , controller:UIViewController) {
        let alertVC = UIAlertController(title: "", message: message, preferredStyle:UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style:UIAlertActionStyle.default, handler: nil)
        alertVC.addAction(okAction)
        controller.present(alertVC, animated: true, completion: nil)
    }

    
     func showAlert(_ message:String,cancleButtonTitle:String,title:String, controller:UIViewController)
    {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: cancleButtonTitle, style:UIAlertActionStyle.default, handler: nil)
        alertVC.addAction(okAction)
        controller.present(alertVC, animated: true, completion: nil)
    }
    
    
    open func showErrorAlert(_ data:Data,cancleButtonTitle:String,title:String, controller:UIViewController) -> Bool
    {
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
            
            var error_message:String = "";
            if (jsonObject ["Title"] != nil) && jsonObject ["Title"] as! String == "apss-response" && (jsonObject ["Description"] != nil) && jsonObject ["Description"] as! String == "errors"
            {
                
                let errorArray:[[String:Any]] = jsonObject ["application errors"] as! [[String:Any]];
                
                if(errorArray.count > 0)
                {
                    let firstErrorObject = errorArray[0];
                    error_message = firstErrorObject["Error"] as! String;
                    
                    
                }
                else
                {
                    error_message = "Unknown error";
                    
                }
                
            }
            else if (jsonObject ["title"] != nil) && jsonObject ["title"] as! String == "Error"
            {//Mapper<BaseMappable>().map(JSON:jsonObject)
//                let errorObject  = MapError.init(key: "Error", currentValue: nil, reason:"JSON Data Not Valid" )
//                error_message = (errorObject.descriptionValue?.errors?[0].error)!
            }
            
            
            // It means here is an error and we show shwo the error and return true
            if(error_message.characters.count > 0)
            {
                ECSAlert().showAlert(error_message,cancleButtonTitle:"OK",title:"", controller:controller);
                return true;
            }
            else
            {
                
                return false;
            }
        }
        catch
        {
            print ("There is an error in convering the data in json object");
            return false
            
        }
        
    }
    
    open func showToast(_ message: String, controller:UIViewController, position:ToastPosition)
    {
        controller.view.makeToast(message,duration: 1.0, position: position)
    }
    

}


class ECSActivity: NSObject {
    

    var controller : UIViewController;
        
    public init(_ controllerL:UIViewController) {
        self.controller = controllerL;
    }
//    open func startAnimating()
//    {
//            let activityView:NVActivityIndicatorView = NVActivityIndicatorView(frame:CGRect(x: controller.view.frame.size.width/2-50, y: controller.view.frame.size.height/2-50, width: 100, height: 100), type: .squareSpin, color: UIColor.black.withAlphaComponent(0.5), padding: 0);
//            activityView.tag = 987654321;
//            controller.view.addSubview(activityView);
//            controller.view.isUserInteractionEnabled = false;
//            activityView.startAnimating();
//    }
//    
//    
//    open func stopAnimating()
//    {
//        let activityView:NVActivityIndicatorView = self.controller.view.viewWithTag(987654321) as! NVActivityIndicatorView!;
//        activityView.stopAnimating();
//        activityView.removeFromSuperview();
//        controller.view.isUserInteractionEnabled = true;
//
//        
//    }

    
}


class ECSDevice: NSObject {
    
    open func getModelName() -> String
    {
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    
    }
    
    
}




class ECSUserDefault: NSObject {
    
    class func getIntFromUserDefault(forKey string: String) -> Int {
        return UserDefaults.standard.integer(forKey: string)
    }
    
    class func getStringFromUserDefault(forKey string: String) -> String {
        return UserDefaults.standard.string(forKey: string) ?? ""
    }
    
    
    class func getObjectFromUserDefault(forKey string: String) -> Any {
        return UserDefaults.standard.object(forKey: string) ?? 0
    }
    
    class func save(_ val: Bool, toUserDefaultForKey string: String) {
        UserDefaults.standard.set(val, forKey: string)
        UserDefaults.standard.synchronize()
    }
    
    class func save(_ val: Int, toUserDefaultForKey string: String) {
        UserDefaults.standard.set(val, forKey: string)
        UserDefaults.standard.synchronize()
    }
    
    class func save(_ val: String, toUserDefaultForKey string: String) {
        UserDefaults.standard.set(val, forKey: string)
        UserDefaults.standard.synchronize()
    }
    
    class func save(_ val: Float, toUserDefaultForKey string: String) {
        UserDefaults.standard.set(val, forKey: string)
        UserDefaults.standard.synchronize()
    }
    
    class func saveObject(_ val: Any, toUserDefaultForKey string: String) {
        UserDefaults.standard.set(val, forKey: string)
        UserDefaults.standard.synchronize()
    }
    
    
    
}


