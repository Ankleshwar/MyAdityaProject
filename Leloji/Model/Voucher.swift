//
//	Voucher.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Voucher : NSObject, NSCoding{

	var amount : Float!
	var currency : String!
	var frequency : String!
	var status : Bool!
	var voucherCode : String!
	var voucherDiscount : String!
	var voucherTitle : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		amount = json["amount"].floatValue
		currency = json["currency"].stringValue
		frequency = json["frequency"].stringValue
		status = json["status"].boolValue
		voucherCode = json["voucher_code"].stringValue
		voucherDiscount = json["voucher_discount"].stringValue
		voucherTitle = json["voucher_title"].stringValue
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
		if status != nil{
			dictionary["status"] = status
		}
		if voucherCode != nil{
			dictionary["voucher_code"] = voucherCode
		}
		if voucherDiscount != nil{
			dictionary["voucher_discount"] = voucherDiscount
		}
		if voucherTitle != nil{
			dictionary["voucher_title"] = voucherTitle
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         amount = aDecoder.decodeObject(forKey: "amount") as? Float
         currency = aDecoder.decodeObject(forKey: "currency") as? String
         frequency = aDecoder.decodeObject(forKey: "frequency") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Bool
         voucherCode = aDecoder.decodeObject(forKey: "voucher_code") as? String
         voucherDiscount = aDecoder.decodeObject(forKey: "voucher_discount") as? String
         voucherTitle = aDecoder.decodeObject(forKey: "voucher_title") as? String

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
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if voucherCode != nil{
			aCoder.encode(voucherCode, forKey: "voucher_code")
		}
		if voucherDiscount != nil{
			aCoder.encode(voucherDiscount, forKey: "voucher_discount")
		}
		if voucherTitle != nil{
			aCoder.encode(voucherTitle, forKey: "voucher_title")
		}

	}

}
