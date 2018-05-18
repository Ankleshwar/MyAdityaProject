//
//  SuggestionVC.swift
//  Leloji
//
//  Created by Ankleshwar on 15/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class SuggestionVC: UIViewController {

    var flowingMenuTransitionManager = FlowingMenuTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        flowingMenuTransitionManager.setInteractivePresentationView(view)
        flowingMenuTransitionManager.delegate = self
    }

    @IBAction func clickToIdea(_ sender: Any) {
        let vc = IdeaSubmission(nibName: "IdeaSubmission", bundle: nil)
         present(vc, animated: true, completion: nil)
    }
    

 

}
extension SuggestionVC: FlowingMenuDelegate{
    
    func setController() {
        
        
        
        let vc = LeftDrawer(nibName: "LeftDrawer", bundle: nil)
        vc.view.frame = self.view.bounds
        vc.transitioningDelegate = flowingMenuTransitionManager
        present(vc, animated: true, completion: nil)
        
    }
    
    
    func colorOfElasticShapeInFlowingMenu(_ flowingMenu: FlowingMenuTransitionManager) -> UIColor? {
        return #colorLiteral(red: 0.2986846537, green: 0.4450575664, blue: 0.8048944473, alpha: 1)
    }
    
    func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        setController()
    }
    
    func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
