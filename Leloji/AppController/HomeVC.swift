//
//  HomeVC.swift
//  VoyMate
//
//  Created by Opiant on 02/04/18.
//  Copyright © 2018 Opiant. All rights reserved.
//

import UIKit



class HomeVC: BaseViewController{


  

    @IBOutlet var flowingMenuTransitionManager: FlowingMenuTransitionManager!
    
    @IBOutlet weak var emojiPanel: EmojiPanel!
    @IBOutlet weak var stickerThumbnil: ThumbnilVC!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet fileprivate var barButton: UIButton!
    @IBOutlet weak var topView: UIView!
    var imgArrayBottomEmoji = NSMutableArray()
    var imgArrayEmoji = NSMutableArray()
    let mainColor      = #colorLiteral(red: 1, green: 0, blue: 0.1483619339, alpha: 1)
    var menu: LeftDrawer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentController.selectedSegmentIndex = 0
        setDataEmoji()
        setEmojiView()
        setBottomView()
        self.emojiPanel.isEmoji = true
        
        flowingMenuTransitionManager.setInteractivePresentationView(view)
        flowingMenuTransitionManager.delegate = self
         
 }
    

    override func viewWillDisappear(_ animated: Bool) {
            self.emojiPanel.isHidden = true
            self.stickerThumbnil.isHidden = true
    }

    

    
    
    func setBottomView(){
        
       
        self.stickerThumbnil.delegate = self
        self.stickerThumbnil.reloadCollection(arrData: self.imgArrayBottomEmoji)
        self.stickerThumbnil.iconSize = CGSize(width: 30.0, height: 30.0)
        self.stickerThumbnil.isKeyboard = false
        self.stickerThumbnil.configeEmojiPanel(panel: self.emojiPanel)
    }
    
    func setEmojiView(){
        
   
        self.emojiPanel.delegate = self
        
        self.emojiPanel.reloadCollection(arrData: self.imgArrayEmoji)
        self.emojiPanel.iconSize = CGSize(width: 100.0, height: 100.0)
    }
    
    
    func setDataEmoji(){
        
      
        self.imgArrayEmoji.removeAllObjects()
        self.imgArrayBottomEmoji.removeAllObjects()
        for var j in 1...15{
            self.imgArrayBottomEmoji.add("b\(j).png")
        }
        for var i in 1...30
        {
            self.imgArrayEmoji.add("a\(i).png")
        }
        
    }
    func setDataGIF(){
        self.imgArrayEmoji.removeAllObjects()
        self.imgArrayBottomEmoji.removeAllObjects()
        
        
        self.imgArrayBottomEmoji.add("pandit.gif")
        
        let strGIF = "voymate"
        
        for var i in 1...5
        {
            self.imgArrayEmoji.add(strGIF)
        }
        
    }

    
    
    @IBAction func clickToSegment(_ sender: Any) {
        if segmentController.selectedSegmentIndex == 0 {
            
    
            setDataEmoji()
            self.emojiPanel.isEmoji = true
            setEmojiView()
            setBottomView()
            
        }
        else{
            setDataGIF()
            self.emojiPanel.isEmoji = false
            setEmojiView()
            setBottomView()
          
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        

        self.emojiPanel.isHidden = false
        self.stickerThumbnil.isHidden = false
        
        
    }
    
    

    

    


    @IBAction func clickToMenu(_ sender: Any) {
        
        setController()

        
    }
    



 


}

extension HomeVC: ThumbnilVCDelegate {
    func didSelectPack(at packPosition: Int) {
        UserDefaults.standard.set(packPosition, forKey: "LastPackKey")
        
        
    }
    
}



extension HomeVC: EmojiPanelDelegate {

    
    func didSelect(image: UIImage!, isPaid: Bool) {
        
        let viewController = DetailsVc(nibName: "DetailsVc", bundle: nil)
        viewController.image = image
         viewController.isEmoji = true
        viewController.isPaidValue = isPaid
        present(viewController, animated: true, completion: nil)
    }
    
    func didSelectGIF(imagename: String!, isPaid: Bool) {
        

        
        let viewController = DetailsVc(nibName: "DetailsVc", bundle: nil)
        viewController.isEmoji = false
        viewController.gifName = imagename
        viewController.isPaidValue = isPaid
        present(viewController, animated: true, completion: nil)
        
    }
    

    
}

extension HomeVC: FlowingMenuDelegate{
    
    func setController() {
        
        
        
        let vc = LeftDrawer(nibName: "LeftDrawer", bundle: nil)
//        vc.view.frame = self.view.bounds
       
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


