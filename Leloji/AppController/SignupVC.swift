//
//  SignupVC.swift
//  VoyMate
//
//  Created by Opiant on 23/04/18.
//  Copyright © 2018 Opiant. All rights reserved.
//

import UIKit

class SignupVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    @IBAction func clickToBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func clickToSignUp(_ sender: Any) {
        let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
        viewController.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
        viewController.modalPresentationStyle = .custom
        present(viewController, animated: true, completion: nil)
        
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
    
}
extension SignupVC: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
