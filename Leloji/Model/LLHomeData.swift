//
//	LLHomeData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class LLHomeData : NSObject, NSCoding{

	var result : [LLResult]!
	var status : Bool!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		result = [LLResult]()
		let resultArray = json["result"].arrayValue
		for resultJson in resultArray{
			let value = LLResult(fromJson: resultJson)
			result.append(value)
		}
		status = json["status"].boolValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if result != nil{
			var dictionaryElements = [[String:Any]]()
			for resultElement in result {
				dictionaryElements.append(resultElement.toDictionary())
			}
			dictionary["result"] = dictionaryElements
		}
		if status != nil{
			dictionary["status"] = status
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         result = aDecoder.decodeObject(forKey: "result") as? [LLResult]
         status = aDecoder.decodeObject(forKey: "status") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if result != nil{
			aCoder.encode(result, forKey: "result")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}
