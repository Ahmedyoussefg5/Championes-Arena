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

    class func GetTimes(id : Int, date : String, complation : @escaping (_ error : Error? , _ status : Bool? , _ messagesArray: [String]? , _ available_time: [String]? , _ unconfirmed: [String]? )->Void) {
        let parameterss: [String: Any] = [
            "playground_id": String(id),
            "date" : date
        ]
        //Get available times and unconfirmed times http://tech.techno-hat.com/champions_arena/public/api/times?playground_id=2&date=2018-09-19
        var messageArray = [String?]()
        //print (parameterss)
        Alamofire.request(getTheTimes, method: .get, parameters: parameterss, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .failure(let error) :
                let json = JSON(error.localizedDescription)
                let status = json["status"].bool
                //print("failure", json)
                messageArray.append("Something gone wrong, please check your internet connection")
                complation(error, status, messageArray as? [String], nil, nil)
                return
            case .success(let value):
                print("Successfully")
                let json = JSON(value)
                print(json)
                guard let status = json["status"].bool else { return }
                if status {
                    /*
                     {
                     "status": true,
                     "api_token_status": true,
                     "available_time": [
                     "07:00",
                     "08:00",
                     "09:00",
                     "01:00"
                     ],
                     "unconfirmed": []
                     }
                     */
                    guard let available_time = json["available_time"].arrayObject else { return }
                    guard let unconfirmed = json["unconfirmed"].arrayObject else { return }
                    //print(available_time)
                    //print(unconfirmed)
                    //ReservationDetails.USERDATA = [userModel]
                    complation(nil, status, messageArray as? [String], available_time as? [String], unconfirmed as? [String]);
                }
                else {
                    /*
                     {
                     "status": false,
                     "api_token_status": true,
                     "message": {
                     "date": [
                     "The date must be a date after yesterday."
                     ]
                     }
                     }
                     */
                    if let message = json["message"].dictionary {
                        if let date = message["date"]?.array {
                            if let dateMessage = date[0].string {
                                //print(dateMessage)
                                messageArray.append(dateMessage)
                            } } }
                }
                complation(nil, status, messageArray as? [String], nil, nil);
            } } }

    
    /// - ******************************************************** -
    
    class func BookTimes(api_token : String, date : String, playground_id: Int, times: [String], complation : @escaping (_ error : Error? , _ status : Bool? , _ messagesArray: [String]? )->Void){

        let parameters: [String: Any] = [
            "api_token": api_token,
            "date" : date,
            "playground_id" : playground_id,
            "times" : times
        ]
        var messageArray = [String?]()
        //print (parameters)
        Alamofire.request(bookTimesurl, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                let status = json["status"].bool
                //print("failure", json)
                messageArray.append("Something gone wrong, please check your internet connection")
                complation(error, status, messageArray as? [String])
                return
            case .success(let value):
                print("Successfully")
                let json = JSON(value)
                //print(json)
                guard let api_token_status = json["api_token_status"].bool, api_token_status == true else {
                    Helper.signOut()
                    messageArray.append("Something gone wrong, please check your internet connection")
                    complation(nil, false, messageArray as? [String])
                    return
                }
                guard let status = json["status"].bool else { messageArray.append("Something gone wrong, please try again later")
                    complation(nil, false, messageArray as? [String])
                    return
                }
                if status {
                    /*
                     {
                     "status" : true,
                     "api_token_status" : true,
                     "message" : "Booking added successfully, Please going pay the booking amount"
                     }
                     */

                    if let message = json["message"].string {
                        messageArray.append(message)
                        complation(nil, status, messageArray as? [String])
                        }
                }
                else {
                    /*
                     {
                     "status" : false,
                     "api_token_status" : false,
                     "message" : "api token not found"
                     }
                     */
                        messageArray.append("Something gone wrong, please check your internet connection")

                    Helper.signOut()
                }
                complation(nil, status, messageArray as? [String]);
            }
        }
    }


}
