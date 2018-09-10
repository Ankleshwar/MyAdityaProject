//
//  UIExtentions.swift
//  TestExtension
//
//  Created by Opiant on 26/12/17.
//  Copyright © 2017 Opiant. All rights reserved.
//

import Foundation
import UIKit

private var extensionGlobal: UIExtensions?

class UIExtensions: NSObject {
    var parentController: UIViewController?
    
    class var sharedInstance: UIExtensions! {
        if !(extensionGlobal != nil) {
            extensionGlobal = UIExtensions()
        }
        return extensionGlobal
    }

    

}

extension UIButton {
   public func makeCircular() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
    public func setButtonImage(_ imageName: String) {
        setImage(UIImage(named: imageName), for: .normal)
    }
    
   public func setAttributedButtonTitle(_ title: NSAttributedString) {
        setAttributedTitle(title, for: .normal)
    }
   public func setButtonTitleColor(_ color: UIColor) {
        setTitleColor(color, for: .normal)
    }
    
   public func setButtonBackgroudImage(_ imageName: String) {
        setBackgroundImage(UIImage(named: imageName), for: .normal)
    }
    
   public func setButtonBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
    public func setButtonTitle(_ title: String) {
        setTitle(title, for: .normal)
    }
    
}



extension UITextField {
    

    
    
        func setBottomBorder(color:String) {
//            self.borderStyle = UITextBorderStyle.none
//            self.backgroundColor = UIColor.clear
//            let width = 1.0
//            
//            let borderLine = UIView(frame: CGRectMake(0, self.frame.height - width, self.frame.width, width))
//            borderLine.backgroundColor = UIColor
//            self.addSubview(borderLine)
//      
        }
    

    func setNumberKeybordWithLeftTitle(_ `left`: String, andRightTitle `right`: String) {
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        //toolBar.barStyle = UIBarStyleBlackOpaque;
        if Float(UIDevice.current.systemVersion) ?? 0.0 >= 7 {
            numberToolbar.barTintColor = UIColor(red: 224.0 / 255.0, green: 225.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
        }
        else {
            numberToolbar.tintColor = UIColor(red: 224.0 / 255.0, green: 225.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
        }
    numberToolbar.items = [UIBarButtonItem(title: `left`, style: .bordered, target: self, action: #selector(self.cancelNumberPad)), UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: `right`, style: .done, target: self, action: #selector(self.doneWithNumberPad))]
    numberToolbar.sizeToFit()
    inputAccessoryView = numberToolbar
    
    
    }
    
    public func setNumberKeybord(_ controller: UIViewController, withLeftTitle `left`: String, andRightTitle `right`: String) {
        UIExtensions.sharedInstance.parentController = controller
        setNumberKeybordWithLeftTitle(`left`, andRightTitle: `right`)
    }
    
    
    @objc func cancelNumberPad() {
                resignFirstResponder()
                text = ""
}
    @objc func doneWithNumberPad() {
      
    }
    
 
  public  func isBlank() -> Bool {
        if text?.count == 0 {
            return true
        }
        return false
    }
        
 public   func setPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: frame.size.height))
        rightView = paddingViewRight
        rightViewMode = .always
    }

 public   func setLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    
  public  func setRightPadding() {
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: frame.size.height))
        rightView = paddingViewRight
        rightViewMode = .always
    }


    func isValidEmail() -> Bool {
        let stricterFilter = true
        if text?.count == 0 {
            return false
        }
        let stricterFilterString = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let laxString = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        let emailRegex: String = stricterFilter ? stricterFilterString : laxString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: text)
    }



}

extension UIPickerView {
    func setUpWithDoneButton() {
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        numberToolbar.barStyle = .blackTranslucent
        numberToolbar.items = [UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelWithNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        numberToolbar.isUserInteractionEnabled = true
        addSubview(numberToolbar)
    }
    
    @objc func doneWithNumberPad(sender: Any) {
        superview?.removeFromSuperview()
    }
    
    @objc func cancelWithNumberPad(sender: Any){
        superview?.removeFromSuperview()
    
    }
}

    
    
extension UITextView {
    func setNumberKeybord() {
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.size.width), height: 50))
        numberToolbar.barStyle = .blackTranslucent
        numberToolbar.items = [UIBarButtonItem(title: "Cancel", style: .bordered, target: self, action: #selector(self.cancelNumberPad)), UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneWithNumberPad))]
        numberToolbar.sizeToFit()
        inputAccessoryView = numberToolbar
    }
    
    @objc func cancelNumberPad() {
        resignFirstResponder()
        text = ""
    }
    
    @objc func doneWithNumberPad() {
        resignFirstResponder()
    }
}
    
    
    
    
    
    
    








public extension UIColor {
    
    public var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    
    
 
    
}



