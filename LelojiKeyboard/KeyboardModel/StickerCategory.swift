//
//  EmojiData.swift
//  LelojiKeyboard
//
//  Created by Ankleshwar on 15/09/18.
//  Copyright © 2018 Opiant tech Solutions Pvt. Ltd. All rights reserved.
//

import Foundation
import RealmSwift

class StickerCategory: Object {
    @objc dynamic var icon: String = ""
    @objc dynamic var name: String = ""
    var stickers = List<StickerData>()
    
  
}
