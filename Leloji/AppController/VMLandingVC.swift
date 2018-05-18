//
//  VMLandingVC.swift
//  VoyMate
//  I have Done my Developer account payment 99$ but my account isn't  activated till now. Please activate my account as soon as possible.

//your quick response will  be appreciated.
//
//Thanks
//Lalit Tehlan
//  Created by Opiant on 27/03/18.
//  Copyright © 2018 Opiant. All rights reserved.
//

import UIKit


class VMLandingVC: BaseViewController  {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnSignUp: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
 

    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imgView.image = UIImage.gifImageWithName("a31")
        self.btnLogin.layer.cornerRadius = 5.0
        self.btnSignUp.layer.cornerRadius = 5.0
        
    }

    @IBAction func clickToSignUp(_ sender: Any) {
        let viewController = SignupVC(nibName: "SignupVC", bundle: nil)
        viewController.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
        viewController.modalPresentationStyle = .custom
        present(viewController, animated: true, completion: nil)
        
    }
    @IBAction func clickTologin(_ sender: Any) {
        
         let viewController = LoginVC(nibName: "LoginVC", bundle: nil)
//        viewController.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
//        viewController.modalPresentationStyle = .custom
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


