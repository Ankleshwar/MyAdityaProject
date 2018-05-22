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
    }
    

    @IBAction func clickToSignUp(_ sender: Any) {
        callSignUpServiec()
        
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
                if (dicData["data"] as? [String : Any]) != nil {
            
                    let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
                    viewController.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
                    viewController.modalPresentationStyle = .custom
                    self.present(viewController, animated: true, completion: nil)
                    
                }
                SVProgressHUD.dismiss()
                
            }
            else{
                
                if let users = dicData["errors"] as? [String : Any] {
                    if let mobile = users["mobileNumber"] as? [String : Any]{
                        
                        let msg = mobile["msg"] as! String
                        ECSAlert().showAlert(message: msg, controller: self)
                        
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
