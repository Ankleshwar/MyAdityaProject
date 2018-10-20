//
//  AppDelegate.swift
//  Leloji
//pod  'GoogleSignIn'
//pod 'ObjectMapper'
//pod 'TextFieldEffects'
//pod 'SwiftyJSON'
//pod 'Alamofire'
//pod "Toast-Swift"
//pod "SwiftKeychainWrapper"
//pod "JWTDecode"
//pod 'YALSideMenu'
//  Created by Opiant tech Solutions Pvt. Ltd. on 18/05/18.
//  Copyright © 2018 Opiant tech Solutions Pvt. Ltd. All rights reserved.
//2207438386170879

import UIKit
import GoogleSignIn
import BraintreeDropIn
import Braintree
import FBSDKLoginKit
import Fabric
import Crashlytics
import GooglePlacePicker
import GoogleMaps
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
  


    var viewController: UIViewController?
    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        setRootController()
        Fabric.with([Crashlytics.self])
        GIDSignIn.sharedInstance().clientID = googleOAuthClientKey
        GIDSignIn.sharedInstance().delegate = self
        GMSPlacesClient.provideAPIKey(googleApikey)
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func setRootController(){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let controllerVelue = UserDefaults.standard.integer(forKey: "isLogin")
        
        if controllerVelue == 1{
            viewController = HomeVC(nibName: "HomeVC", bundle: nil)
        }
        else{
            viewController = LoginVC(nibName: "LoginVC", bundle: nil)
        }
      //  viewController = LoginVC(nibName: "LoginVC", bundle: nil)
        navigationController = UINavigationController(rootViewController: (viewController)!)
         BTAppSwitch.setReturnURLScheme("com.lelojicreatives.leloji.payments")
        self.window?.rootViewController = self.navigationController
        navigationController?.navigationBar.isHidden = true
        window?.makeKeyAndVisible()
    }
    
    
    
    //MARK: Social Login Requier Method
    
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
//    }
    
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            if url.scheme?.localizedCaseInsensitiveCompare("com.lelojicreatives.leloji.payments") == .orderedSame {
                return BTAppSwitch.handleOpen(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String)
            }
            return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: [:]) || FBSDKApplicationDelegate.sharedInstance().application(application, open: url, options: options)
    }

  
    

    
//    private func application(application: UIApplication,
//                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
//        var _: [String: AnyObject] = [UIApplicationOpenURLOptionsKey.sourceApplication.rawValue: sourceApplication as AnyObject,
//                                            UIApplicationOpenURLOptionsKey.annotation.rawValue: annotation!]
//        return GIDSignIn.sharedInstance().handle(url as URL?,
//                                                    sourceApplication: sourceApplication,
//                                                    annotation: annotation)
//    }
//

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
           // self.callSignUpServiec(firstName: fullName ?? "", lastName: "", email: email ?? "", id: userId ?? "")
           
            
            let viewController = SignupVC(nibName: "SignupVC", bundle: nil)
            viewController.strName = fullName ?? ""
            viewController.strEmail =  email ?? ""
            viewController.strId = userId ?? ""
            viewController.strType = 3
            self.navigationController?.pushViewController(viewController, animated: true)
           
        }
    }
    
    
    
    func callSignUpServiec(firstName:String,lastName:String,email:String,id:String){
        
        
        let dic = [ "firstName": firstName,
                    "lastName": lastName,
                    "email": email,
                    "socialId": id,
                    "signupType":2
            ] as [String : Any]
        
        SVProgressHUD.show()
        ServiceClass().signUpDetails(strUrl:"auth/signup", param: dic ) { error , dicData  in
            
            if error != nil {
                
                
    
                
                
                if let users = dicData["error"] as? [String : Any] {
                    
                    for errData in (users as? [String : Any])!{
                        print(errData)
                        
                    }
                    
                    
                    
                    
                }
                
                
                
                
                
                SVProgressHUD.dismiss()
                
            }
            else{
                
               
                
                
                let viewController = SignupVC(nibName: "SignupVC", bundle: nil)
                viewController.strName = firstName
                viewController.strEmail = email
                viewController.strId = id
                viewController.strType = 2
                self.navigationController?.pushViewController(viewController, animated: true)
                
                SVProgressHUD.dismiss()
                
                
                
            }
            
        }
    }
    
    


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

