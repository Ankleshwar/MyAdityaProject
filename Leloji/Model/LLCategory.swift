//
//	LLCategory.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class LLCategory : NSObject, NSCoding{

	var icon : String!
	var name : String!
	var stickers : [LLSticker]!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		icon = json["icon"].stringValue
		name = json["name"].stringValue
		stickers = [LLSticker]()
		let stickersArray = json["stickers"].arrayValue
		for stickersJson in stickersArray{
			let value = LLSticker(fromJson: stickersJson)
			stickers.append(value)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if icon != nil{
			dictionary["icon"] = icon
		}
		if name != nil{
			dictionary["name"] = name
		}
		if stickers != nil{
			var dictionaryElements = [[String:Any]]()
			for stickersElement in stickers {
				dictionaryElements.append(stickersElement.toDictionary())
			}
			dictionary["stickers"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         icon = aDecoder.decodeObject(forKey: "icon") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         stickers = aDecoder.decodeObject(forKey: "stickers") as? [LLSticker]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if icon != nil{
			aCoder.encode(icon, forKey: "icon")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if stickers != nil{
			aCoder.encode(stickers, forKey: "stickers")
		}

	}

}
