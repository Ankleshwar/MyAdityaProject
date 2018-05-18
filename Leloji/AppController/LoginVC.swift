//
//  LoginVC.swift
//  VoyMate
//
//  Created by Opiant on 23/04/18.
//  Copyright © 2018 Opiant. All rights reserved.
//

import UIKit
import TextFieldEffects

class LoginVC: BaseViewController {
    @IBOutlet weak var txtEmail: TextFieldEffects!
  
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var txtPassword: TextFieldEffects!
    
    var txtField = TextFieldEffects()
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

      //  self.txtEmail.setBottomBorder(color: "")
        
        self.imgView.image = UIImage.gifImageWithName("pandit")
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.view.removeFromSuperview()
    }

    @IBAction func clickToLogin(_ sender: Any) {
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
    
    
    
}
extension LoginVC: UITextFieldDelegate{

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
      
    }
    
}
