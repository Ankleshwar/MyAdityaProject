//
//	LLSticker.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class LLSticker : NSObject, NSCoding{

	var id : String!
	var category : String!
	var dateCreated : String!
	var dateModified : String!
	var descriptionField : String!
	var image : String!
	var isPaid : String!
	var isPaidB : Bool!
	var name : String!
	var tags : [String]!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		id = json["_id"].stringValue
		category = json["category"].stringValue
		dateCreated = json["date_created"].stringValue
		dateModified = json["date_modified"].stringValue
		descriptionField = json["description"].stringValue
		image = json["image"].stringValue
		isPaid = json["isPaid"].stringValue
		isPaidB = json["isPaidB"].boolValue
		name = json["name"].stringValue
		tags = [String]()
		let tagsArray = json["tags"].arrayValue
		for tagsJson in tagsArray{
			tags.append(tagsJson.stringValue)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["_id"] = id
		}
		if category != nil{
			dictionary["category"] = category
		}
		if dateCreated != nil{
			dictionary["date_created"] = dateCreated
		}
		if dateModified != nil{
			dictionary["date_modified"] = dateModified
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if image != nil{
			dictionary["image"] = image
		}
		if isPaid != nil{
			dictionary["isPaid"] = isPaid
		}
		if isPaidB != nil{
			dictionary["isPaidB"] = isPaidB
		}
		if name != nil{
			dictionary["name"] = name
		}
		if tags != nil{
			dictionary["tags"] = tags
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         category = aDecoder.decodeObject(forKey: "category") as? String
         dateCreated = aDecoder.decodeObject(forKey: "date_created") as? String
         dateModified = aDecoder.decodeObject(forKey: "date_modified") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         image = aDecoder.decodeObject(forKey: "image") as? String
         isPaid = aDecoder.decodeObject(forKey: "isPaid") as? String
         isPaidB = aDecoder.decodeObject(forKey: "isPaidB") as? Bool
         name = aDecoder.decodeObject(forKey: "name") as? String
         tags = aDecoder.decodeObject(forKey: "tags") as? [String]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if category != nil{
			aCoder.encode(category, forKey: "category")
		}
		if dateCreated != nil{
			aCoder.encode(dateCreated, forKey: "date_created")
		}
		if dateModified != nil{
			aCoder.encode(dateModified, forKey: "date_modified")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if isPaid != nil{
			aCoder.encode(isPaid, forKey: "isPaid")
		}
		if isPaidB != nil{
			aCoder.encode(isPaidB, forKey: "isPaidB")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if tags != nil{
			aCoder.encode(tags, forKey: "tags")
		}

	}

}
