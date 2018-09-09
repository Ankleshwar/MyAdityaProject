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
    
    
    
    public func homeData(strUrl:String,prama:[String:String],completion: @escaping (JSONTaskCompletionHandler)){
        print(baseURL+strUrl)
        
        requestGETURL(baseURL+strUrl, params: nil, headers: nil, success: {
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
    
    
    
    
    
    
    
    
    
    public func getDataForSearchCity(strUrl:String,prama:[String:String],completion: @escaping (arrayBlock)){
      
        
        requestGETURL(baseURL+strUrl, params: nil, headers: nil, success: {
                    (JSONResponse) -> Void in
                    print(JSONResponse)
  
   
//
//            for rootdic  in JSONResponse.arrayObject! {
//                if let obj = rootdic as? [String: Any] {
//                   // let object = PlaceObject(JSON: obj)
//                  //  self.arrIteam.append(object)
//                }
//
//            }
//
          
            completion(nil,self.arrIteam)
           
     
            
            }){
            (error) -> Void in
                
                completion(error,[])
                       
        }
        
        //            for responseDic  in    JSONResponse["wsResponse"]{
        //                print(responseDic)
        //                if "0" == (responseDic.0){
        //                    for rootdic  in JSONResponse.dictionaryObject! {
        //                        print(rootdic)
        //                        if rootdic is [String: Any] {
        //
        //                              print(rootdic)
        //
        //                        }
        //
        //                    }
        //
        //
        //
        //                completion(nil,self.arrIteam)
        //            }
        //
        //
        //            }
        //

       
        
        
    }
    
    
    
    public func getDataBusList(strUrl:String,prama:[String: AnyObject],completion: @escaping (arrayBlock)){
        
        print(prama)
        
        
        
        
//        requestPOSTURL(baseURL+strUrl, params: prama, headers: nil, success: {
//            (JSONResponse) -> Void in
//
//            print(JSONResponse)
//
//            print(JSONResponse.dictionaryObject!)
//            self.arrIteam.removeAll()
////            if "SUCCESS" == JSONResponse["wsResponse"]["message"]{
////                for rootdic in JSONResponse["service"].array!{
////
////                        let object = IBService(fromJson: rootdic)
////                        self.arrIteam.append(object)
////
////
////
////
////                }
//                completion(nil, self.arrIteam)
//        }
//            else{
//                let errorTemp = NSError(domain:"No Service Avilable", code:205, userInfo:nil)
//                completion(errorTemp,[])
//            }
//
//
//
//
//
//
//
//        }){
//            (error) -> Void in
//
//            completion(error,[])
//
//        }
//
        
        
        
        
    }
    
    public func getNearByPlace(prama:[String: AnyObject],completion: @escaping (arrayBlock)){
        
                //print(prama)
        
       let lat = prama["lat"] as! Double
       let lng = prama["lng"] as! Double
       let type = prama["type"] as! String
       let commanUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(lng)&radius=5000&type=\(type)&key=AIzaSyBfK9hv6qIpL7vLV-WRa1qkiNzD4ix1Hjc"
        
        requestGETURL(commanUrl, params: [:], headers: nil, success: {
                    (JSONResponse) -> Void in
        
                   // print(JSONResponse)
        
                    print(JSONResponse.dictionaryObject!)
                    self.arrIteam.removeAll()
                    if "OK" == JSONResponse["status"]{
                        for rootdic in JSONResponse["results"].array!{
        
                              
        
//                            let object = VMGooglePlaceData(fromJson: rootdic)
//                            self.arrIteam.append(object)
        
        
                        }
                        completion(nil, self.arrIteam)
                }
                    else{
                        let errorTemp = NSError(domain:"No Service Avilable", code:205, userInfo:nil)
                        completion(errorTemp,[])
                    }
        
        
        
        
        
        
        
                }){
                    (error) -> Void in
    
                    completion(error,[])
    
                }
    
        
        
        
        
    }
    


    
    private  func requestGETURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            
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
