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
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.isHidden = true
    }
    
    @IBAction func clickToMenu(_ sender: Any) {
        
        setController()
        
        
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
        return #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    }
    
    func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        setController()
    }
    
    func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
