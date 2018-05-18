//
//  DetailsVc.swift
//  Leloji
//
//  Created by Ankleshwar on 03/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class DetailsVc: UIViewController {

    @IBOutlet weak var viewPardaa: UIView!
    
    @IBOutlet weak var btnShare: UIButton!
        var isEmoji: Bool!
        var isPaidValue: Bool!
        var gifName: String!
    @IBOutlet weak var imgView: UIImageView?
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isEmoji == true {
            self.imgView?.image = image
        }
        else{
           self.imgView?.image = UIImage.gifImageWithName(gifName)
        }
        
        
        
        
       
        if isPaidValue == true {
            self.viewPardaa.isHidden = false
            btnShare.setButtonTitle("Subscribe")
        }
        else{
            self.viewPardaa.isHidden = true
            btnShare.setButtonTitle("Share")
        }
        detectScreenShot { () -> () in
            print("User took a screen shot")
        }
      
    }


    
    @IBAction func clickToBack(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    func detectScreenShot(action: @escaping () -> ()) {
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: .UIApplicationUserDidTakeScreenshot, object: nil, queue: mainQueue) { notification in
     
            action()
        }
    }

}
