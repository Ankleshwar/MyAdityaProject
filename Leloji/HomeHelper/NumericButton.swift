//
//  NumericButton.swift
//  Keyboard
//
//  Created by Alexey Golovenkov on 04/12/2017.
//  Copyright © 2017 ROKOLABS. All rights reserved.
//

import UIKit

let labels: [String: String] =  ["2": "ABC", "3": "DEF", "4": "GHI", "5": "JKL", "6": "MNO", "7": "PQRS", "8": "TUV", "9": "WZXY"]

class NumericButton: UIButton {
    
    let label: UILabel

    required init?(coder aDecoder: NSCoder) {
        label = UILabel()
        super.init(coder: aDecoder)
        
        self.titleLabel?.font = UIFont(name: "SFUIText-Regular", size:25) ?? UIFont.boldSystemFont(ofSize: 25)
        
        label.text = labels[self.title(for: .normal) ?? "2"]
        label.font = UIFont(name: "SFUIText-Bold", size:10) ?? UIFont.boldSystemFont(ofSize: 10)
        label.frame = (label.text! as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options:.usesLineFragmentOrigin, attributes: [.font: label.font], context: nil)
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var labelFrame = label.frame
        labelFrame.origin.x = (self.bounds.size.width - labelFrame.width) / 2.0
        labelFrame.origin.y = self.bounds.maxY - labelFrame.size.height - 3.0
        label.frame = labelFrame
    }
}
