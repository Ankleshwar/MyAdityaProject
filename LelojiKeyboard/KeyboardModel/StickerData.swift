//
//  StikerData.swift
//  LelojiKeyboard
//
//  Created by Ankleshwar on 06/10/18.
//  Copyright © 2018 Opiant tech Solutions Pvt. Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class StickerData: Object {
 
        @objc dynamic   var id : String = ""
        @objc dynamic   var category : String = ""
        @objc dynamic   var dateCreated : String = ""
        @objc dynamic   var dateModified : String = ""
        @objc dynamic   var descriptionField : String = ""
        @objc dynamic   var image : String = ""
        @objc dynamic   var isPaid : String = ""
        @objc dynamic   var name : String = ""
        var parentCategory = LinkingObjects(fromType: StickerCategory.self, property: "stickers")
    
    convenience init(obj:LLSticker) {
        self.init()
        self.id = obj.id
        self.category = obj.category
        self.dateCreated = obj.dateCreated
        self.dateModified = obj.dateModified
        self.descriptionField = obj.descriptionField
        self.image = obj.image
        self.isPaid = obj.isPaid
        self.name = obj.name
        
    }
    

    
}
