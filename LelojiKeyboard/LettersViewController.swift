//
//  LettersViewController.swift
//  Keyboard
//
//  Created by Alex Golovenkov on 02/12/2017.
//  Copyright © 2017 ROKOLABS. All rights reserved.
//

import UIKit

class LettersViewController: UIViewController, KeyboardController {
    var height: CGFloat = LettersViewController.defaultHeight()
    var shift: Bool = true {
        willSet {
            if (shift == newValue) {
                return
            }
            updateCapitalization(capitalization: newValue, in: self.view)
        }
    }
    
    @IBOutlet var twoLevelNamedButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureKeyboard() {
        updateButtonsBackground(in: self.view)
        updateTwoLevelNamedButtons()
    }
    
    func updateTwoLevelNamedButtons() {
        if twoLevelNamedButtons == nil {
            return
        }
        for button in twoLevelNamedButtons {
            button.titleLabel?.numberOfLines = 2
            button.titleLabel?.lineBreakMode = .byWordWrapping
            button.titleLabel?.textAlignment = .center
            guard var buttonText = button.titleLabel?.text else {
                continue
            }
            if buttonText.count > 1 {
                buttonText.insert("\n", at: buttonText.index(after: buttonText.startIndex))
            }
            button.setTitle(buttonText, for: .normal)
        }
    }
    
    func updateButtonsBackground(in view:UIView) {
        let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        for subview in view.subviews {
            if let stackView = subview as? UIStackView {
                updateButtonsBackground(in: stackView)
                continue
            }
            guard let button = subview as? UIButton else {
                continue
            }
            let initialImage = button.backgroundImage(for: .normal)
            let image = initialImage?.resizableImage(withCapInsets: insets)
            button.setBackgroundImage(image, for: .normal)
        }
    }
    
    @IBAction func removeKeyboardButtonPressed() {
        self.keyboardController()?.dismissKeyboard()
    }
    
    @IBAction func emojiButtonPressed() {
        self.keyboardController()?.type = .stickers
    }
    
    @IBAction func numbersButtonPressed() {
        self.keyboardController()?.type = .numbers
    }
    
    @IBAction func globeButtonPressed() {
        self.keyboardController()?.globePressed();
    }
    
    @IBAction func deleteButtonPressed() {
        self.keyboardController()?.backspacePressed()
    }
    
    @IBAction func lettersButtonPressed() {
        self.keyboardController()?.type = .letters
    }
    
    @IBAction func returnButtonPressed() {
        self.keyboardController()?.textDocumentProxy.insertText("\n")
    }
    
    @IBAction func letterButtonPressed(_ button: UIButton) {
        guard let buttonText = button.titleLabel?.text else {
            return
        }
        if buttonText.count < 3 {
            self.keyboardController()?.textDocumentProxy.insertText(buttonText)
        } else {
            let index = buttonText.index(buttonText.startIndex, offsetBy: 2)
            let text = shift ? buttonText[buttonText.startIndex] : buttonText[index]
            self.keyboardController()?.textDocumentProxy.insertText("\(text)")
        }
        self.shift = false
    }
    
    @IBAction func spaceTap(_ sender: UITapGestureRecognizer) {
        self.keyboardController()?.textDocumentProxy.insertText(" ")
    }
    
    @IBAction func spaceDoubleTap(_ sender: UITapGestureRecognizer) {
        self.keyboardController()?.textDocumentProxy.deleteBackward()
        self.keyboardController()?.textDocumentProxy.insertText(". ")
    }
    
    @IBAction func shiftButtonPressed() {
        self.shift = !self.shift
    }
    
    func updateCapitalization(capitalization: Bool, in view: UIView) {
        for subview in view.subviews {
            if let stackView = subview as? UIStackView {
                updateCapitalization(capitalization: capitalization, in: stackView)
                continue
            }
            guard let button = subview as? UIButton else {
                continue
            }
            guard let buttonText = button.title(for: .normal) else {
                continue
            }
            if buttonText.count != 1 {
                continue
            }
            let newText = capitalization ? buttonText.uppercased() : buttonText.lowercased()
            button.setTitle(newText, for: .normal)
        }
    }
}
