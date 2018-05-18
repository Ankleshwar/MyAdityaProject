//
//  ServiceHelper.swift
//  DMS
//
//  Created by Shreesh Garg on 14/03/17.
//  Copyright © 2017 Shreesh Garg. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftKeychainWrapper
import JWTDecode



public class ServiceHelper
{
    public func isServiceCallRequired(serviceName:String) -> Bool
    {
    
        // Here we need to check if there is any time stamp saved in correspondant to service name 
        
        // if yes, then we need to check if it has been called more than 2 hours 
        // We are saving the time stamp of service call to user default for future ref
        
        let prevServiceCallTimeEpoch = UserDefaults.standard.double(forKey:serviceName) as Double
        let currentTimeEpoch = Date().timeIntervalSince1970 * 1000
        
        if prevServiceCallTimeEpoch > 0
        {
             let timeGap = currentTimeEpoch - prevServiceCallTimeEpoch
             if(timeGap > 7200000)
             {
                  // we need to be sure that time gap must be greater tahn 2 hrs
                return true;
            
            
             }
            return false;
         }
        
        return true;
    
    }
    
    public func getServiceJSONResponse(serviceName:String) -> Data
    {
        
        // We will be saving the JSON data with each api call to user default
        // If there is any api call name ABC, user defualt variable will be saved as ABC_JSON
        
        
        return UserDefaults.standard.data(forKey:serviceName+"_JSON")!
    }
    
    public func saveServiceJSONResponse(_ responseData:Data, for serviceName:String)
    {
        
        // We will be saving the JSON data with each api call to user default
        // If there is any api call name ABC, user defualt variable will be saved as ABC_JSON
         UserDefaults.standard.set(responseData, forKey: serviceName+"_JSON")
    }
    
    public func saveServiceCallTimeStamp(serviceName:String)
    {
        
        // We will be saving the JSON data with each api call to user default
        // If there is any api call name ABC, user defualt variable will be saved as ABC_JSON
        
        UserDefaults.standard.set(Date().timeIntervalSince1970 * 1000, forKey: serviceName)

    }
    
    
    open func isError(_ jsonObject:[String:Any]) -> Bool
    {
        var error_message:String = "";
        if (jsonObject ["Title"] != nil) && jsonObject ["Title"] as! String == "apss-response" && (jsonObject ["Description"] != nil) && jsonObject ["Description"] as! String == "errors"
        {
            
            let errorArray:[[String:Any]] = jsonObject ["application errors"] as! [[String:Any]];
            
            if(errorArray.count > 0)
            {
                let firstErrorObject = errorArray[0];
                error_message = firstErrorObject["Error"] as! String;
                
                
            }
            else
            {
                error_message = "Unknown error";
                
            }
            
        }
        else if (jsonObject ["title"] != nil) && jsonObject ["title"] as! String == "Error"
        {
//            let errorObject  = Mapper<ErrorObject>().map(JSON:jsonObject)
//            error_message = (errorObject?.descriptionValue?.errors?[0].error)!
        }
        
        
        // It means here is an error and we show shwo the error and return true
        if(error_message.characters.count > 0)
        {
            return true;
        }
        else
        {
            
            return false;
        }
        
    }
    
    
    open func isAccessTokenValid() -> Bool
    {
        
        let token = KeychainWrapper.standard.string(forKey: "", withAccessibility:nil)!
        do
        {
             let jwt = try decode(jwt: token)
             return !jwt.expired;
        
        }
        catch _ {
            print("There is an error is decrypting the JWT code")
        }

        return false;
    
    
    }
   


}
