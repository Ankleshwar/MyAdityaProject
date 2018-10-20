//
//	MembershipPlan.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class MembershipPlan : NSObject, NSCoding{

	var amount : Int!
	var currency : String!
	var frequency : String!
	var id : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		amount = json["amount"].intValue
		currency = json["currency"].stringValue
		frequency = json["frequency"].stringValue
		id = json["id"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if amount != nil{
			dictionary["amount"] = amount
		}
		if currency != nil{
			dictionary["currency"] = currency
		}
		if frequency != nil{
			dictionary["frequency"] = frequency
		}
		if id != nil{
			dictionary["id"] = id
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         amount = aDecoder.decodeObject(forKey: "amount") as? Int
         currency = aDecoder.decodeObject(forKey: "currency") as? String
         frequency = aDecoder.decodeObject(forKey: "frequency") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if amount != nil{
			aCoder.encode(amount, forKey: "amount")
		}
		if currency != nil{
			aCoder.encode(currency, forKey: "currency")
		}
		if frequency != nil{
			aCoder.encode(frequency, forKey: "frequency")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}

	}

}
