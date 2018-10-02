//
//  StickerViewController.swift
//  LelojiKeyboard
//
//  Created by Ankleshwar on 16/04/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//


let kPressPasteTitleShowDuration = 2.5
let kPressPasteTitleAppearDuration = 0.5

import UIKit

class StickerViewController: UIViewController ,KeyboardController  {
    var height: CGFloat = StickerViewController.defaultHeight()
    
    @IBOutlet weak var hintView: UIView!
    
    @IBOutlet weak var emojiPanel: EmojiPanel!
     var hintButton: UIButton!
    var imgArrayThumbnil = NSMutableArray()
    var imgArray : [LLSticker]!
    
    @IBOutlet weak var stickerThumbnil: ThumbnilVC!
    func configureKeyboard() {
        
        let isAccess = self.keyboardController()?.hasFullAccess ?? false
            if isAccess {
                self.height = StickerViewController.fullHeight()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        print(imgArrayThumbnil)
        print(imgArray)
     
        setView()
        
        
     
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory leac")
    }
    
    

    
    


    
    func  setView(){
        configureStikers()
        hintView.isHidden = true
        self.stickerThumbnil.delegate = self
        self.emojiPanel.delegate = self
        self.stickerThumbnil.reloadCollection(arrData: self.imgArrayThumbnil)
        self.stickerThumbnil.iconSize = CGSize(width: 30.0, height: 30.0)
        self.stickerThumbnil.isKeyboard = true
        self.emojiPanel.reloadCollection(arrData: self.imgArray)
        self.emojiPanel.isEmoji = true
        self.stickerThumbnil.configeEmojiPanel(panel: self.emojiPanel)
        configuteHintButton()
    }
    
    
    fileprivate func configureStikers(){
        
//        self.imgArray.add("a31.gif")
//        for var i in 1...30
//        {
//            self.imgArray.add("a\(i).png")
//        }
//
//         self.imgArray.add("a31.gif")
//
//        for var j in 1...15{
//            self.imgArrayThumbnil.add("b\(j).png")
//        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        self.stickerThumbnil.scrollTo()
      
        
        
    }
    
    
 
    
    override func viewWillDisappear(_ animated: Bool) {
        // hintButton.removeFromSuperview()
        
       // stickerThumbnil.removeFromSuperview()
    
    }

    @IBAction func clickGlobe(_ sender: AnyObject) {
       
        self.keyboardController()?.globePressed();
    }
    @IBAction func lettersButtonPressed() {
        self.keyboardController()?.type = .letters
    }
    
    @IBAction func numbersButtonPressed() {
        self.keyboardController()?.type = .numbers
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
         self.keyboardController()?.backspacePressed()
    }
    
    fileprivate func configuteHintButton() {
        hintView.backgroundColor = UIColor(red: 32/255.0, green: 59/255.0, blue: 104/255.0, alpha: 0.7)

        let fontSize:CGFloat = 16.0
        let button = UIButton(frame: CGRect(x:0, y: 0, width: 140, height: 100))
        hintButton = button
        let font1 = UIFont(name: "SFUIText-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        let font2 = UIFont(name: "SFUIText-Bold", size:fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        let color = UIColor.white

        let myNormalAttributedTitle = NSMutableAttributedString(string: "Copied to the clipboard. Now tap and\n",
                                                                attributes: [NSAttributedStringKey.font : font1, NSAttributedStringKey.foregroundColor: color ])

        let myBoldAttributedTitle = NSAttributedString(string: " paste ",
                                                       attributes: [NSAttributedStringKey.font : font2, NSAttributedStringKey.foregroundColor: color])
        let myLastAttributedTitle = NSAttributedString(string: " into the message field",
                                                       attributes: [NSAttributedStringKey.font : font1, NSAttributedStringKey.foregroundColor: color])
        myNormalAttributedTitle.append(myBoldAttributedTitle)
        myNormalAttributedTitle.append(myLastAttributedTitle)
        hintButton.translatesAutoresizingMaskIntoConstraints = false
        hintButton.setAttributedTitle(myNormalAttributedTitle, for: .normal)


        hintButton.layer.cornerRadius = 10
        hintButton.titleLabel!.numberOfLines = 2
        hintButton.titleLabel!.lineBreakMode = .byWordWrapping;
        hintButton.titleLabel!.textAlignment = .center;


        hintView.addSubview(hintButton)

        let centerX = NSLayoutConstraint(item: hintView, attribute: .centerX, relatedBy: .equal, toItem: hintButton, attribute: .centerX, multiplier: 1, constant: 0)

        let centerY = NSLayoutConstraint(item: hintView, attribute: .centerY, relatedBy: .equal, toItem: hintButton, attribute: .centerY, multiplier: 1, constant: 0)

        NSLayoutConstraint.activate([centerX, centerY])
    }

    fileprivate func hideHint(){
        self.hintView.isHidden = true
    }

    fileprivate func showHint(){
        self.hintView.isHidden = false
        self.hintView.alpha = 0
        UIView.animate(withDuration: kPressPasteTitleAppearDuration, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.hintView!.alpha = 1
        }, completion: { (Bool) -> () in
            UIView.animate(withDuration: kPressPasteTitleAppearDuration, delay: kPressPasteTitleShowDuration, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.hintView!.alpha = 0
            }, completion: nil)
        })
    }

}

extension StickerViewController: StickerDataSource {
   
    
    var arrThumbnilData: NSMutableArray {
        get {
            return self.imgArray as! NSMutableArray
        }
        set {


            self.arrThumbnilData  =  self.imgArray as! NSMutableArray
        }
    }
    

    


}

extension StickerViewController: EmojiPanelDelegate {
   
    

    func didSelectGIF(imagename: String!) {
        let url: URL = Bundle.main.url(forResource: imagename, withExtension: ".gif")! as URL
        do {
            let imageData = try Data(contentsOf: url as URL)
            UIPasteboard.general.setData(imageData , forPasteboardType: "com.compuserve.gif")
            showHint()
        } catch {
            print("Unable to load data: \(error)")
        }
    }
    
    func didSelect(image: UIImage!) {
        
      print(ClipboardManager.isOpenAccessGranted())  
        
            ClipboardManager.copy(image)
            showHint()
        
    }

}

extension StickerViewController: ThumbnilVCDelegate {
    func didSelectPack(at packPosition: Int) {
        UserDefaults.standard.set(packPosition, forKey: "LastPackKey")
    
   
    }
    
}

extension UIInputViewController {
    
    func openURL(url: NSURL) -> Bool {
        do {
            let application = try self.sharedApplication()
            application.performSelector(inBackground: "openURL:", with: url)
            return true
        }
        catch {
            return false
        }
    }
    
    func sharedApplication() throws -> UIApplication {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application
            }
            
            responder = responder?.next
        }
        
        throw NSError(domain: "UIInputViewController+sharedApplication.swift", code: 1, userInfo: nil)
    }
    
}

