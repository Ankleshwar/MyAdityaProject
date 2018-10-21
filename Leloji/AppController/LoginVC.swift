//
//  LoginVC.swift
//  VoyMate
//  GIDSignIn.sharedInstance().signOut()
//  Created by Opiant on 23/04/18.
//  Copyright © 2018 Opiant. All rights reserved.
//

import UIKit
import TextFieldEffects
import  GoogleSignIn
import SVProgressHUD
import FBSDKCoreKit
import FBSDKLoginKit





class LoginVC: BaseViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var txtEmail: TextFieldEffects!
     var viewController: SocialLogin?
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewFb: UIView!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBOutlet weak var txtPassword: TextFieldEffects!
    
    @IBOutlet weak var btnFacebookLogin: FBSDKLoginButton!
    
    
    var txtField = TextFieldEffects()
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

      //  self.txtEmail.setBottomBorder(color: "")
       
        self.imgView.image = UIImage.gifImageWithName("final time")
        GIDSignIn.sharedInstance().uiDelegate = self
        self.btnFacebookLogin.readPermissions = ["public_profile", "email", "user_friends"]
        self.btnFacebookLogin.delegate = self
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.view.removeFromSuperview()
    }

    @IBAction func clickToLogin(_ sender: Any) {

        if txtEmail.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter Email", controller: self)
        }else     if txtPassword.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter Password", controller: self)
        }
        else{
                 callLoginServiec()

        }
       //setHomeController()
    }
    
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                returnUserData()
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print(error?.localizedDescription)
            }
            else
            {
                print("fetched user: \(result)")
                let dict = result as! [String : AnyObject]
                let userName : NSString = dict["name"] as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = dict["email"] as! NSString
                print("User Email is: \(userEmail)")
                let userID : NSString = dict["id"] as! NSString
                print("User ID is: \(userID)")
                print(dict)
                self.callSignUpServiec(firstName: userName as String, lastName: "", email: userEmail as String, id: userID as String)
                
              
            }
        })
    }
    
    func callSignUpServiec(firstName:String,lastName:String,email:String,id:String){
        
        
        let dic = [ "firstName": firstName,
                    "lastName": lastName,
                    "email": email,
                    "socialId": id,
                    "signupType":2
            ] as [String : Any]
        
        SVProgressHUD.show()
        ServiceClass().signUpDetails(strUrl:"auth/socialsignup", param: dic ) { error , dicData  in
            
            if error != nil {
                
                
                
                
                let viewController = SignupVC(nibName: "SignupVC", bundle: nil)
                viewController.strName = firstName
                viewController.strEmail = email
                viewController.strId = id
                viewController.strType = 2
                self.navigationController?.pushViewController(viewController, animated: true)
                
                
                
                
                
                
                SVProgressHUD.dismiss()
                
            }
            else{
                
                
                self.appUserObject = AppUserObject.instance(from: dicData)
                self.appUserObject?.token = dicData["auth_token"] as! String
                self.appUserObject?.saveToUserDefault()
                UserDefaults.standard.set(1, forKey: "isLogin")
                UserDefaults.standard.synchronize()
                let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
                self.present(viewController, animated: true, completion: nil)
             
                
                SVProgressHUD.dismiss()
                
                
                
            }
            
        }
    }
    
    
    
    
    
   public func setHomeController() {
    
    UserDefaults.standard.set(1, forKey: "isLogin")
    UserDefaults.standard.synchronize()
    
    let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
    self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func clickToBack(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickToSignUp(_ sender: Any) {

        let viewController = SignupVC(nibName: "SignupVC", bundle: nil)
        viewController.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
        viewController.modalPresentationStyle = .custom
        present(viewController, animated: true, completion: nil)
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present

        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss

        return transition
    }
    
    func callLoginServiec(){
        
        SVProgressHUD.show()
        
        
        let dic = [
                   "email":self.txtEmail.text,
                   "password": self.txtPassword.text,
               
        ]
        
        ServiceClass().getLoginDetails(strUrl:"auth/login", param: dic as! [String : String] ) { error , dicData  in
            
            if error != nil{
                ECSAlert().showAlert(message: (error?.localizedDescription)!, controller: self)
                SVProgressHUD.dismiss()
            }
            else{
                 self.appUserObject = AppUserObject.instance(from: dicData)
                self.appUserObject?.token = dicData["auth_token"] as! String
                self.appUserObject?.saveToUserDefault()
                UserDefaults.standard.set(1, forKey: "isLogin")
                UserDefaults.standard.synchronize()
                let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
                self.present(viewController, animated: true, completion: nil)
                SVProgressHUD.dismiss()
            }
        }
    }

    
}
extension LoginVC: UITextFieldDelegate{

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
      
    }
    
}

extension LoginVC: GIDSignInUIDelegate{
    
    private func signInWillDispatch(signIn: GIDSignIn!, error: Error!) {
       // myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Userfull



//if dicData["status"] as!String == "Ok" {
//    if let dicSuccessData = dicData["successData"] as? [String : Any]{
//
//        if let data = dicSuccessData["userData"] as? [String : Any]{
//            self.appUserObject = AppUserObject.instance(from: data)
//
//            self.appUserObject?.email = data["email"] as! String
//            self.appUserObject?.userName = data["name"] as! String
//            self.appUserObject?.userId = "\(data["id"])"
//
//
//            //                        guard let myString =  self.nullToNil( value: data["phone"] as AnyObject ) , !(myString as AnyObject).isEmpty else {
//            //                            print("String is nil or empty.")
//            //                            SVProgressHUD.dismiss()
//            //                            return // or break, continue, throw
//            //                        }
//
//
//            //   self.appUserObject?.mobile = "\(myString)"
//            self.appUserObject?.token = dicSuccessData["token"] as! String
//            self.appUserObject?.saveToUserDefault()
//            let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
//            self.present(viewController, animated: true, completion: nil)
//        }
//}
