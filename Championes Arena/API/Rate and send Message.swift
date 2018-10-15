//
//  File.swift
//  Champione Arena
//
//  Created by Youssef on 9/18/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension ApiMethods {
    
    //http://localhost/champile/public/api/message?api_token=56756&message=Hello%20new%20message
    class func sendMessage(message: String, complation : @escaping (_ error : Error? , _ status : Bool? , _ messagesArray: [String]? )->Void) {
        let parameters: [String: String] = [
            "api_token" : Helper.getAPIToken()!,
            "message" : message
        ]
        //print (parameters)
        Alamofire.request(messageUrl, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .failure(let error):
                let json = JSON(error)
                complation(error, false, nil)
                print("failure", json)
                return
            case .success(let value):
                let json = JSON(value)
                print(json)
                guard let status = json["status"].bool else { return }
                if status {
                    complation(nil, true, nil)
                    return }
                else {
                    complation(nil, false, nil)
                }
                return
            }
        }
    }
    
    //http://localhost/champile/public/api/rate?api_token=4334&rate=5&comment=768
    class func rate_(rate: Int, comment: String, complation : @escaping (_ error : Error? , _ status : Bool? , _ done: Bool )->Void) {
        let parameters: [String: Any] = [
            "api_token" : Helper.getAPIToken()!,
            "rate" : rate,
            "comment" : comment
        ]
        //print (parameters)
        Alamofire.request(check_RateURL, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .failure(let error):
                let json = JSON(error)
                complation(error, false, false)
                print("failure", json)
                return
            case .success(let value):
                let json = JSON(value)
                print(json)
                guard let status = json["status"].bool else { return }
                if status {
                    guard let ratey = json["rate"].bool else { return }
                    if !ratey {
                        Alamofire.request(rateUrl, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
                            response in
                            switch response.result {
                            case .failure(let error):
                                let json = JSON(error)
                                complation(error, false, false)
                                print("failure", json)
                                return
                            case .success(let value):
                                let json = JSON(value)
                                print(json)
                                guard let status = json["status"].bool else { return }
                                if status {
                                    complation(nil, true, true); return }
                                else { complation(nil, false, false) }
                                return } } }
                    else {complation(nil, true, false)}
                } } } }
            
}
        
        
