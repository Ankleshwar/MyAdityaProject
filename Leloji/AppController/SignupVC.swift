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
   
    @IBOutlet weak var txtConfirmPass: HoshiTextField!
    @IBOutlet weak var txtCountryCode: HoshiTextField!
    @IBOutlet weak var txtState: HoshiTextField!
    @IBOutlet weak var txtLastName: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var txtFirstName: HoshiTextField!
    
    
    
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

        if txtFirstName.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter Your Name", controller: self)
        }else if txtEmail.text?.count == 0{
            ECSAlert().showAlert(message: "Please Enter valid Email", controller: self)
        }else if strEmail.isValidEmail() == false {
             ECSAlert().showAlert(message: "Please Enter valid Email", controller: self)
        }
            
        else if txtPassword.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter Your Password", controller: self)
        }
        else if txtConfirmPass.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter Your Confirm Password", controller: self)
        }
            
        else if isEqual (txtPassword.text == txtConfirmPass.text) {
            ECSAlert().showAlert(message: "Please Match  Your Password", controller: self)
        }
        else{
            callSignUpServiec()
        }
        
//        let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
//        self.present(viewController, animated: true, completion: nil)
        
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
        
    
        let dic = [ "firstName": self.txtFirstName.text ?? "",
                   "lastName":self.txtLastName.text ?? "",
                   "password": self.txtPassword.text ?? "",
                   "countryCode": self.txtCountryCode.text ?? "",
                   "email": self.txtEmail.text ?? "",
                   "state":self.txtState.text ?? "",
                   "signupType":1
            ] as [String : Any]
        
         SVProgressHUD.show()
        ServiceClass().signUpDetails(strUrl:"auth/signup", param: dic ) { error , dicData  in
            
            if dicData["status"] as! Bool == true {

               
                    
                
                self.appUserObject = AppUserObject.instance(from: dicData)
                self.appUserObject?.token = dicData["auth_token"] as! String
                self.appUserObject?.saveToUserDefault()
                UserDefaults.standard.set(1, forKey: "isLogin")
                UserDefaults.standard.synchronize()
                let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
                self.present(viewController, animated: true, completion: nil)
                        
                    
                
               
                
                
                SVProgressHUD.dismiss()
                
            }
            else{
                
                if let users = dicData["error"] as? [String : Any] {
              
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
