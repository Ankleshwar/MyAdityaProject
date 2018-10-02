//
//  KeyboardViewController.swift
//  JimoniKeyboard
//
//  Created by Opiant on 04/04/18.
//  Copyright © 2018 Opiant. All rights reserved.
//

import UIKit
import MobileCoreServices
import RealmSwift



class ImageCollectionViewCell:UICollectionViewCell {
    @IBOutlet var imgView:UIImageView!
}



enum KeyboardType {
   
    case letters
    case numbers
    case stickers
    
    
    func controller(thumbnilArray:NSMutableArray,arrEmoji:[LLSticker]) -> UIViewController & KeyboardController {
        switch self {
        case .stickers :
             let lettersController = StickerViewController(nibName: "StickerViewController", bundle: nil)
                lettersController.imgArrayThumbnil = thumbnilArray
                lettersController.imgArray = arrEmoji
            return lettersController
        case .letters:
            let lettersController = LettersViewController(nibName: "LettersViewController", bundle: nil)
            return lettersController
        case .numbers:
            let lettersController = LettersViewController(nibName: "NumbersViewController", bundle: nil)
            return lettersController
        }
    }
}

protocol KeyboardContolPanelController {
    func backspacePressed()
    func globePressed()
    func numericButtonPressed()
    func alphabetButtonPressed()
   
 
}
class KeyboardViewController: UIInputViewController{

    
    var imgArrayThumbnilMain = NSMutableArray()
    var imgArrayMain : [LLSticker]!
    var heightConstraint: NSLayoutConstraint!
    @IBOutlet var collectionView: UICollectionView!
    
    var imgArray = NSMutableArray()
    
    override func updateViewConstraints()
    {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
        if (view.frame.size.width == 0 || view.frame.size.height == 0) {
            return
        }
        
        setUpHeightConstraint()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let realm = try Realm()
        }catch{
            print("Error to initialising realm \(error)")
        }
        

  

    }
    
    
    func getHomeData() {
        
        ServiceClass().homeData(strUrl:"emojis/stickers", prama: [:] as! [String : String] ) { (result)  in
            switch result {
            case .Error(let _):
                do {
                    // ECSAlert().showAlert(message: (error.localizedDescription), controller: self)
                    self.reloadKeyboard()
                }
            case .Success(let json):
                let obj = LLHomeData(fromJson: json)
                for i in 0 ..< obj.result.count{
                    self.imgArrayThumbnilMain.add(obj.result[i].category)
                    self.imgArrayMain = obj.result[0].category.stickers
                }
                

                
                self.reloadKeyboard()
            }
            
            
        }
    }
    
    
    func setUpHeightConstraint()
    {
        let customHeight = 240
        
        if heightConstraint == nil {
            heightConstraint = NSLayoutConstraint(item: view,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: CGFloat(customHeight))
            heightConstraint.priority = UILayoutPriority.required
            
            view.addConstraint(heightConstraint)
        }
        else {
            heightConstraint.constant = CGFloat(customHeight)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        var _expandedHeight: CGFloat = 240
//        var _heightConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: _expandedHeight)
//        view.addConstraint(heightConstraint)
        
        
        getHomeData()
        
        
    }
    
    var type = KeyboardType.stickers {
        didSet {
            self.reloadKeyboard()
        }
    }
 
    
    private func reloadKeyboard() {
        if let oldKeyboard = self.childViewControllers.first {
            oldKeyboard.view.removeFromSuperview()
            oldKeyboard.removeFromParentViewController()
        }
        
        let keyboard = self.type.controller(thumbnilArray: self.imgArrayThumbnilMain, arrEmoji: imgArrayMain)
        keyboard.view.frame = self.view.bounds
        print(keyboard.view.frame)
        self.view.addSubview(keyboard.view)
        self.addChildViewController(keyboard)
      
    }
    

    


    

    
    @IBAction func returnPressed(_ sender: Any) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    
    @IBAction func nextKeyboardPressed(_ sender: Any) {
          advanceToNextInputMode()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    

    
    


}


extension KeyboardViewController: KeyboardContolPanelController {
 
    
    func backspacePressed() {
        switch textDocumentProxy.documentContextBeforeInput {
        case let s where s?.hasSuffix("    ") == true: // Cursor in front of tab, so delete tab.
            for _ in 0..<4 { // TODO: Update to use tab setting.
                textDocumentProxy.deleteBackward()
            }
        default:
            textDocumentProxy.deleteBackward()
        }
    }
    
    func globePressed() {
        advanceToNextInputMode()
    }
    
    func numericButtonPressed() {
        
    }
    
    func alphabetButtonPressed() {
        
    }
  
}

