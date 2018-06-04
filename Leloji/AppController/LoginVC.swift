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


class LoginVC: BaseViewController {
    @IBOutlet weak var txtEmail: TextFieldEffects!
     var viewController: SocialLogin?
    @IBOutlet weak var imgView: UIImageView!
  
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBOutlet weak var txtPassword: TextFieldEffects!
    
    var txtField = TextFieldEffects()
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

      //  self.txtEmail.setBottomBorder(color: "")
        
        self.imgView.image = UIImage.gifImageWithName("pandit")
        GIDSignIn.sharedInstance().uiDelegate = self
        
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
       
    }
    
   public func setHomeController() {
        let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
        present(viewController, animated: true, completion: nil)
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
        
        ServiceClass().getLoginDetails(strUrl:"login", param: dic as! [String : String] ) { error , dicData  in
            
            if dicData["status"] as!String == "Ok" {
                if let dicSuccessData = dicData["successData"] as? [String : Any]{
                    
                    if let data = dicSuccessData["userData"] as? [String : Any]{
                    self.appUserObject = AppUserObject.instance(from: data)
                    
                    self.appUserObject?.email = data["email"] as! String
                    self.appUserObject?.userName = data["name"] as! String
                    self.appUserObject?.userId = "\(data["id"])"
                    
                    
                    //                        guard let myString =  self.nullToNil( value: data["phone"] as AnyObject ) , !(myString as AnyObject).isEmpty else {
                    //                            print("String is nil or empty.")
                    //                            SVProgressHUD.dismiss()
                    //                            return // or break, continue, throw
                    //                        }
                    
                    
                    //   self.appUserObject?.mobile = "\(myString)"
                        self.appUserObject?.token = dicSuccessData["token"] as! String
                    self.appUserObject?.saveToUserDefault()
                    let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
                    self.present(viewController, animated: true, completion: nil)
                 }
                }
                SVProgressHUD.dismiss()
                
            }
            else{
                
        
                        let msg = dicData["error"] as! String
                        ECSAlert().showAlert(message: msg, controller: self)
                        
              
                
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


