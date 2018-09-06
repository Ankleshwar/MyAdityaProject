//
//  RateUs.swift
//  Leloji
//
//  Created by Ankleshwar on 14/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class RateUs: UIViewController {
    @IBOutlet var flowingMenuTransitionManager: FlowingMenuTransitionManager!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        flowingMenuTransitionManager.setInteractivePresentationView(view)
        flowingMenuTransitionManager.delegate = self
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

extension RateUs: FlowingMenuDelegate{
    func setController() {
        
        
        
        let vc = LeftDrawer(nibName: "LeftDrawer", bundle: nil)
        vc.view.frame = self.view.bounds
        vc.transitioningDelegate = flowingMenuTransitionManager
        present(vc, animated: true, completion: nil)
        
    }
    
    
    func colorOfElasticShapeInFlowingMenu(_ flowingMenu: FlowingMenuTransitionManager) -> UIColor? {
        return #colorLiteral(red: 0.01176470588, green: 0.9921568627, blue: 0.9843137255, alpha: 1)
    }
    
    func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        setController()
    }
    
    func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
