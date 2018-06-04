//
//  SignupVC.swift
//  VoyMate
//
//  Created by Opiant on 23/04/18.
//  Copyright © 2018 Opiant. All rights reserved.
//

import UIKit
import SVProgressHUD
import TextFieldEffects

class SignupVC: BaseViewController {
    @IBOutlet weak var txtConfPassword: HoshiTextField!
    
    @IBOutlet weak var txtreffral: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var txtName: HoshiTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    @IBAction func clickToBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       // self.txtEmail.textRect(forBounds: self.txtEmail.bounds)
    }
    

    @IBAction func clickToSignUp(_ sender: Any) {
        
        let strEmail : String
        strEmail = txtEmail.text!
        
        if txtName.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter Your Name", controller: self)
        }else if txtEmail.text?.count == 0{
            ECSAlert().showAlert(message: "Please Enter valid Email", controller: self)
        }
        else if txtPassword.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter Your Password", controller: self)
        }
        else if txtConfPassword.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter Your Confirm Password", controller: self)
        }
        else if isEqual (txtPassword.text == txtConfPassword.text) {
            ECSAlert().showAlert(message: "Please Match  Your Password", controller: self)
        }
        else{
            callSignUpServiec()
        }
        
        
        
        print("value added")
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        
        return transition
    }
    
    
    
    
    
    func callSignUpServiec(){
        
        SVProgressHUD.show()
        
        
        let dic = ["name":self.txtName.text,
                   "email":self.txtEmail.text,
                   "password": self.txtPassword.text,
                    "password_confirmation": self.txtConfPassword.text,
                    "referral_code":self.txtreffral.text
                   ]
        
        ServiceClass().signUpDetails(strUrl:"register", param: dic as! [String : String] ) { error , dicData  in
            
            if dicData["status"] as!String == "Ok" {

                
                if let dicSuccessData = dicData["successData"] as? [String : Any]{
                    
                    if let data = dicSuccessData["data"] as? [String : Any]{
                        self.appUserObject = AppUserObject.instance(from: data)
                        
                        self.appUserObject?.email = data["email"] as! String
                        self.appUserObject?.userName = data["name"] as! String
                        self.appUserObject?.userId = "\(data["id"])"
                        
                        
                        guard let myString =  self.nullToNil( value: data["phone"] as AnyObject ) , !(myString as AnyObject).isEmpty else {
//                            print("String is nil or empty.")
//                            SVProgressHUD.dismiss()
//                            return // or break, continue, throw
//                        }
                        
                        
                     //   self.appUserObject?.mobile = "\(myString)"
                        self.appUserObject?.saveToUserDefault()
                        let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
                        self.present(viewController, animated: true, completion: nil)
                        
                    }
                }
               
                
                
                SVProgressHUD.dismiss()
                
            }
            else{
                
                if let users = dicData["errorData"] as? [String : Any] {
              
                    for errData in (users as? [String : Any])!{
                        print(errData)
                      //  let msg = 
                      //  ECSAlert().showAlert(message: msg, controller: self)
                    }
                        
                    
                        
                    
                }
                
                SVProgressHUD.dismiss()
                
                
                
            }
            
        }
    }
    
    
    }
    
    
    
    
}
extension SignupVC: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
class MyCustomTextField : UITextField {
    var leftMargin : CGFloat = 10.0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = bounds
        newBounds.origin.x += leftMargin
        return newBounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = bounds
        newBounds.origin.x += leftMargin
        return newBounds
    }
}
