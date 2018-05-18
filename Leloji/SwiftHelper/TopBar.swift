//
//  TopBar.swift
//  IndusBus
//
//  Created by Opiant on 11/01/18.
//  Copyright © 2018 Opiant. All rights reserved.
//

import UIKit

class TopBar: BaseViewController {
    
  

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var btnBack: UIButton!

    @IBOutlet weak var lblHeading: UILabel!
    var controller: UIViewController?
    var heading = ""
    var headerButtonTitle = ""
    var headerButtonImage = ""
    var isVisible = false
    var isHidden = false
    @IBOutlet weak var btnHeader: UIButton!

    
    convenience init(controller: UIViewController, withTitle headerTitle: String) {
        self.init(nibName: "TopBar", bundle: nil)
        self.controller = controller
        heading = headerTitle
    }
    convenience init(controller: UIViewController, withTitle headerTitle: String, withButton isVisible: Bool, withButtonTitle buttonTitle: String, withButtonImage buttonBackgroundImage: String, withoutBackButton isHidden: Bool) {
        self.init(controller: controller, withTitle: headerTitle)
        self.isVisible = isVisible
        headerButtonTitle = buttonTitle
        headerButtonImage = buttonBackgroundImage
        self.isHidden = isHidden
    }
    
    func showButton() {
        if isVisible == true {
            btnHeader.isHidden = false
            btnHeader.setTitle(headerButtonTitle, for: .normal)
            btnHeader.setButtonImage(headerButtonImage)
        }
        else {
            btnHeader.isHidden = true
        }
       
    }
    
    func hideBackButton() {
        
        if controller?.navigationController?.viewControllers.count == 1 {
            btnBack.isHidden = true
        }
    }

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Custom initialization
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblHeading.text = heading
        
        showButton()
        hideBackButton()
        let rect = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: Int(viewTop.frame.size.height))
        viewTop.frame = rect
        calculateTheWidthOfTopRightButton()
        
    }
    func calculateTheWidthOfTopRightButton() {
        
        let lable = UILabel(frame: btnHeader.frame)
        lable.font = btnHeader.titleLabel?.font
        lable.text = btnHeader.titleLabel?.text
        
        if lable.frame.size.width + 8 > btnHeader.frame.size.width {
            btnHeader.frame = CGRect(x: btnHeader.frame.origin.x + btnHeader.frame.size.width - lable.frame.size.width - 5, y: btnHeader.frame.origin.y, width: lable.frame.size.width + 8, height: btnHeader.frame.size.height)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let rect = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: Int(viewTop.frame.size.height))
        viewTop.frame = rect
        calculateTheWidthOfTopRightButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func clickToGoBack(_ sender: Any) {
        
        if (controller?.canPerformAction(#selector(self.leftButtonClicked), withSender: sender))! {
            controller?.perform(#selector(self.leftButtonClicked), with: sender)
        }
        else {
            controller?.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clickForHeader(_ sender: Any) {
         controller?.perform(#selector(self.rightButtonClicked), with: sender)
    }
    
 
  
   
    @objc func rightButtonClicked(_ sender: Any) {
    }
    
    @objc func leftButtonClicked(_ sender: Any) {
    }

}
