//
//  ServiceClass.swift
//  IndusBus
//
//  Created by Opiant on 29/01/18.
//  Copyright © 2018 Opiant. All rights reserved.
// http://indusbus.opiant.online/api/osrtc/getavailableservices

import Foundation
import Alamofire
import SwiftyJSON


enum Result <T>{
    case Success(T)
  case Error(ItunesApiError)
}
enum ItunesApiError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case invalidURL
    case jsonParsingFailure
}

class ServiceClass: NSObject {
    
    typealias dictionaryBlock = (_ error: Error?, _ response: [String:Any]) -> Void
    typealias arrayBlock = (_ error: Error?, _ response: [Any]) -> Void
     typealias JSONTaskCompletionHandler = (Result<JSON>) -> ()

    
    var headers: [String: String] = [:]
    var body: String?
    var elapsedTime: TimeInterval?
    var arrIteam : Array<Any> = []
    
   
    
    var request: Alamofire.Request? {
        didSet {
            oldValue?.cancel()
            headers.removeAll()
            body = nil
            elapsedTime = nil
            
        }
    }
    
    
    public func copyImageData(strUrl:String,param:[String:AnyObject],header:String,completion:@escaping (dictionaryBlock)){
        //var appUserObject: AppUserObject?
       // print(appUserObject?.token)
        
        let headersValue = [
            "Authorization": "secret \(header)",
            
        ]
        
        requestPOSTURL(baseURL+strUrl, params: param as [String : AnyObject], headers: headersValue, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            let dicData = JSONResponse.dictionaryObject!
            if dicData["status"] as! Bool == true {
                completion(nil,JSONResponse.dictionaryObject!)
            }else{
                let msg = dicData["error"] as! String
                
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                
                completion(error as Error,[:])
                
                
            }
            
            
            
            
            
            
            
        }) {
            (error) -> Void in
            
            completion(error as Error,[:])
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    public func getLoginDetails(strUrl:String,param:[String:String],completion:@escaping (dictionaryBlock)){
        
        print(param)
        
        requestPOSTURL(baseURL+strUrl, params: param as [String : AnyObject], headers: nil, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
             let dicData = JSONResponse.dictionaryObject!
            if dicData["status"] as! Bool == true {
                completion(nil,JSONResponse.dictionaryObject!)
            }else{
                let msg = dicData["error"] as! String
                
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                
                completion(error as Error,[:])
             
                
            }
            
            
            
           
            
            
            
        }) {
            (error) -> Void in
            
            completion(error as Error,[:])
            
        }
    }
    
    
    
    public func getBrainTreeToken(strUrl:String,prama:[String:String],header:String,completion: @escaping (JSONTaskCompletionHandler)){
        print(baseURL+strUrl)
        
        let headersValue: HTTPHeaders = [
            "Authorization": "secret \(header)"
            
        ]
        
        requestGETURL(baseURL+strUrl, params: nil, headers: headersValue, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            let dicData = JSONResponse.dictionaryObject!
            if dicData["status"] as! Bool == true {
                completion(.Success(JSONResponse))
            }else{
                let msg = dicData["error"] as! String
                
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                
                completion(.Error(.jsonConversionFailure))
                
                
            }
            
            
            
            
            
            
            
        }) {
            (error) -> Void in
            print(error)
            completion(.Error(.responseUnsuccessful))
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    public func sendPaymentNonch(strUrl:String,prama:[String:Any],header:String,completion: @escaping (JSONTaskCompletionHandler)){
        print(baseURL+strUrl)
        print(prama)
        let headersValue: HTTPHeaders = [
            "Authorization": "secret \(header)"
            
        ]
        
        requestPOSTURL(baseURL+strUrl, params: prama as [String : AnyObject], headers: headersValue, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            let dicData = JSONResponse.dictionaryObject!
            if dicData["status"] as! Bool == true {
                completion(.Success(JSONResponse))
            }else{
                let msg = dicData["error"] as! String
                
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                
                completion(.Error(.jsonConversionFailure))
                
                
            }
            
            
            
            
            
            
            
        }) {
            (error) -> Void in
            print(error)
            completion(.Error(.responseUnsuccessful))
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    public func getDiscountedData(strUrl:String,prama:[String:String],header:String,completion: @escaping (JSONTaskCompletionHandler)){
        print(baseURL+strUrl)
        
        let headersValue: HTTPHeaders = [
            "Authorization": "secret \(header)"
            
        ]
        
        requestPOSTURL(baseURL+strUrl, params: prama as [String : AnyObject], headers: headersValue, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            let dicData = JSONResponse.dictionaryObject!
            if dicData["status"] as! Bool == true {
                completion(.Success(JSONResponse))
            }else{
                let msg = dicData["error"] as! String
                
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                
                completion(.Error(.jsonConversionFailure))
                
                
            }
            
            
            
            
            
            
            
        }) {
            (error) -> Void in
            print(error)
            completion(.Error(.responseUnsuccessful))
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    public func homeData(strUrl:String,prama:[String:String],header:String,completion: @escaping (JSONTaskCompletionHandler)){
        print(baseURL+strUrl)
       
        let headersValue: HTTPHeaders = [
            "Authorization": "secret \(header)"
            
        ]
        
        requestGETURL(baseURL+strUrl, params: nil, headers: headersValue, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            let dicData = JSONResponse.dictionaryObject!
            if dicData["status"] as! Bool == true {
                completion(.Success(JSONResponse))
            }else{
                let msg = dicData["error"] as! String
                
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                
               completion(.Error(.jsonConversionFailure))
                
                
            }
            
            
            
            
            
            
            
        }) {
            (error) -> Void in
            print(error)
            completion(.Error(.responseUnsuccessful))
            
        }
        

        
        
        
        
    }
    
    
    
    
    
    
    public func signUpDetails(strUrl:String,param:[String:Any],completion:@escaping (dictionaryBlock)){
        
        print(param)
        
        let dicHeader = [ "Content-Type": "application/json"]

        
        
        let headersValue: HTTPHeaders = [
             "Content-Type": "application/json"
            
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: param, options: [])
            
            if let utf8 = String(data: data, encoding: .utf8) {
                print("JSON: \(utf8)")
                
                let json = utf8
                
                let url = URL(string: baseURL+strUrl)!
                let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
                
                var request = URLRequest(url: url)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                request.allHTTPHeaderFields = headersValue
                
                Alamofire.request(request).responseJSON {
                    (response) in
                    
                    print(response)
                    
                    if response.result.isSuccess {
                        let resJson = JSON(response.result.value!)
                        
                        let dicData = resJson.dictionaryObject!
                        
                        if dicData["status"] as! Bool == true {
                         
                            completion(nil,dicData)
                        }
                        else{
                            let msg = dicData["error"] as! String
                            
                            let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                            
                            completion(error as Error,[:])
                        }
                        
                        
                        
                        
                    }
                    if response.result.isFailure {
                        let error : Error = response.result.error!
                        completion(error,[:])
                    }
                    
                    
                    
                }
                
                
            }
        } catch {
            print(error)
        }
            
        
        
    }
    
    
    
    
    
    
    
    
    
  
    
    
    
  
    

    


    
    private  func requestGETURL(_ strURL : String, params : [String : AnyObject]?, headers : HTTPHeaders, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        print(headers)
        Alamofire.request(strURL, headers: headers).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    private func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
}
