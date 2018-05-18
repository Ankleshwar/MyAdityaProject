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

class ServiceClass: NSObject {
    
    typealias dictionaryBlock = (_ error: Error?, _ response: [String:Any]) -> Void
    typealias arrayBlock = (_ error: Error?, _ response: [Any]) -> Void
    

    
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
