//
//  KeyboardViewController.swift
//  JimoniKeyboard
//
//  Created by Opiant on 04/04/18.
//  Copyright © 2018 Opiant. All rights reserved.
//

import UIKit
import MobileCoreServices

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
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

       
        

  

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
    
    
    override func viewWillAppear(_ animated: Bool) {
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
        self.view.addSubview(keyboard.view)
        self.addChildViewController(keyboard)
      
    }
    

    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
      
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

//extension KeyboardViewController: UICollectionViewDelegate,UICollectionViewDataSource{
//
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.imgArray.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let iCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath as IndexPath) as! ImageCollectionViewCell
//        iCell.imgView.image = UIImage(named: self.imgArray.object(at: indexPath.row) as! String)
//        if indexPath.row == 30 {
//            let imgGIF = UIImage.gifImageWithName("a31")
//            iCell.imgView .image = imgGIF
//
//        }
//
//
//        return iCell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let pb = UIPasteboard.general
//        if indexPath.row == 30 {
//            let url: URL = Bundle.main.url(forResource: "a31", withExtension: ".gif")! as URL
//            do {
//                let imageData = try Data(contentsOf: url as URL)
//                pb.setData(imageData , forPasteboardType: "com.compuserve.gif")
//            } catch {
//                print("Unable to load data: \(error)")
//            }
//        }
//        else{
//            let data = UIImagePNGRepresentation( UIImage(named: self.imgArray.object(at: indexPath.row) as! String)!)
//            pb.setData(data!, forPasteboardType: kUTTypePNG as String)
//        }
//
//
//
//
//
//        let iCell = self.collectionView.cellForItem(at: indexPath as IndexPath) as! ImageCollectionViewCell
//        UIView.animate(withDuration: 0.2, animations: {
//            iCell.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
//        }, completion: {(_) -> Void in
//            iCell.transform =
//                CGAffineTransform(scaleX: 1.0, y: 1.0)
//        })
//        (textDocumentProxy as UIKeyInput).insertText("")
//
//    }
//}

//extension KeyboardViewController : UICollectionViewDelegateFlowLayout{
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      //  let collectionViewWidth = collectionView.bounds.width
//
//
//        return CGSize(width: 50 , height: 50)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//}

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

