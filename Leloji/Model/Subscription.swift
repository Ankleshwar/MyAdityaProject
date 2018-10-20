//
//	Subscription.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Subscription : NSObject, NSCoding{

	var braintreeToken : String!
	var membershipPlan : MembershipPlan!
	var status : Bool!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		braintreeToken = json["braintree_token"].stringValue
		let membershipPlanJson = json["membership_plan"]
		if !membershipPlanJson.isEmpty{
			membershipPlan = MembershipPlan(fromJson: membershipPlanJson)
		}
		status = json["status"].boolValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if braintreeToken != nil{
			dictionary["braintree_token"] = braintreeToken
		}
		if membershipPlan != nil{
			dictionary["membership_plan"] = membershipPlan.toDictionary()
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
         braintreeToken = aDecoder.decodeObject(forKey: "braintree_token") as? String
         membershipPlan = aDecoder.decodeObject(forKey: "membership_plan") as? MembershipPlan
         status = aDecoder.decodeObject(forKey: "status") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if braintreeToken != nil{
			aCoder.encode(braintreeToken, forKey: "braintree_token")
		}
		if membershipPlan != nil{
			aCoder.encode(membershipPlan, forKey: "membership_plan")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}
