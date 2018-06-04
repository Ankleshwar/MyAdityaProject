//
//  BaseViewController.swift
//  TestExtension
//
//  Created by Opiant on 27/12/17.
//  Copyright © 2017 Opiant. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleSignIn



class BaseViewController: UIViewController {
    
    var screenWidth: Float = 0.0
    var screenHeight: Float = 0.0
    var topBar: TopBar?
    var appUserObject: AppUserObject?
    var appDelegate: AppDelegate?
    let transition = BubbleTransition()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        screenWidth = Float(UIScreen.main.bounds.size.width)
        screenHeight = Float(UIScreen.main.bounds.size.height)
        
        appUserObject = AppUserObject.getFromUserDefault()
     //   appDelegate?.getLocation()
        
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        }
    
    
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
    
    
    func setDataWithLocalJson(_ key: String) -> Array<Any> {
        let filePath: String? = Bundle.main.path(forResource: "LocalText", ofType: "json")
        let data = NSData(contentsOfFile: filePath ?? "") as Data?
        var error: Error? = nil
        let rootdic = (try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])) as? [AnyHashable: Any]
        let arrMain = rootdic?[key] as? [Any]
       // print("\(arrMain)")
        return (arrMain as! NSArray) as! Array<Any>
    }
    
   // func checkLocationSetting() -> Bool {
        
    //    print(UserDefaults.standard.object(forKey: "HasLaunchedOnce"))
        
//        
//            if CLLocationManager.locationServicesEnabled() {
//                switch CLLocationManager.authorizationStatus() {
//                case .notDetermined, .restricted, .denied:
//                    //print("No access")
////                    let alert = UIAlertView(title: "Location Error!", message: "Location Access has been denied for VoyMate!", delegate: nil, cancelButtonTitle: "Ok")
//                    
//                    
//                    // alert.tag=500;
//                    alert.show()
//                    return false
//                case .authorizedAlways, .authorizedWhenInUse:
//                    print("Access")
//                    return true
//                    
//                }
//            } else {
//               // print("Location services are not enabled")
////                let alert = UIAlertView(title: "Location Error!", message: "Location services are not enabled!", delegate: nil, cancelButtonTitle: "Ok")
//                // alert.tag=500;
//                alert.show()
//                return false
//            }
 //       }
        
        
    func logOutUser(){
        GIDSignIn.sharedInstance().signOut()
        
    }
    
    
   public func isFirstTime(){
        if !UserDefaults.standard.bool(forKey: "HasLaunchedOnce") {
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
        }

    }
    
    
    
    
    func settingTopView(_ view: UIView, on controller: UIViewController, andTitle title: String) {
     //   let firstFrame = CGRect(x: 0, y: 0, width: Int(self.screenWidth), height: 46)
       
        topBar = (TopBar(controller: controller, withTitle: title) as? TopBar)!
        view.addSubview((topBar?.view)!)
    }
    
    func setTopView(_ view: UIView, on controller: UIViewController, andTitle headerTitle: String, withButton isVisible: Bool, withButtonTitle buttonTitle: String, withButtonImage buttonBackgroundImage: String, withoutBackButton isHidden: Bool) {
        topBar = (TopBar(controller: controller, withTitle: headerTitle, withButton: isVisible, withButtonTitle: buttonTitle, withButtonImage: buttonBackgroundImage, withoutBackButton: isHidden) as? TopBar)!
        view.addSubview((topBar?.view)!)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
      
    }

    
}
