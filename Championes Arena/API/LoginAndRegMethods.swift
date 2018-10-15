import Foundation
import Alamofire
import SwiftyJSON

class ApiMethods {
    
    // MARK: - API REGISTER
    //http://localhost/champile/public/api/users/register?email=ahmed@gmail.com&password=123456&username=Ahmed&phone=01041256369
    class func RegisterUser(name : String, email : String, phone : String, password : String, complation : @escaping (_ error : Error?, _ status : Bool?, _ messagesArray: [String] )->Void){
        let parameters: [String: String] = [
            "email": email,
            "password" : password,
            "username" : name,
            "phone" : phone
        ]
        var messageArray = [String?]()
        //print (parameters)
        Alamofire.request(registerURL, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                let status = json["status"].bool
                print("failure", json)
                messageArray.append("Something gone wrong, please check your internet connection")
                complation(error, status, messageArray as! [String])
                return
            case .success(let value):
                /*
                 {
                 "status": true,
                 "api_token": "75bc00b34271637caeb5a08ea770fe976230e15a349a8c29a6a42a3c7a6e09810640c5e1",
                 "message": "Register Successfully",
                 "user": {
                 "username": "Ahmed",
                 "email": "a@ad.aa",
                 "phone": "010sd412df5r6s369",
                 "birthday": null,
                 "updated_at": "2018-09-17 15:30:03",
                 "created_at": "2018-09-17 15:30:03",
                 "id": 9
                 }
                 }
                 */
                //print("Successfully")
                let json = JSON(value)
                //print(json)
                guard let status = json["status"].bool else { return }
                if status {
                    let message = json["message"].string
                    messageArray.append(message)
                    // save api token
                    if let api_token = json["api_token"].string {
                        print(api_token)
                        Helper.saveIPItoken(apistring: api_token)
                        DispatchQueue.main.async {
                            ApiMethods.RegisterUserOn_OneSignal()
                        }
                        //if let user = json["user"].dictionary {
                        let userModel = UserModel.init(List: json.dictionary!)
                        ReservationDetails.USERDATA = [userModel]
                        //print(userModel.email, userModel.api_token)
                        complation(nil, status, messageArray as! [String]);
                    } }
                else {
                    /*
                     {
                     "status": false,
                     "message": {
                     "email": [
                     "The email has already been taken."
                     ],
                     "phone": [
                     "The phone has already been taken."
                     ]
                     }
                     }
                     */
                    if let message = json["message"].dictionary {
                        if let email = message["email"]?.array {
                            if let emailMessage = email[0].string {
                                //print(emailMessage)
                                messageArray.append(emailMessage)
                            } }
                        if let phone = message["phone"]?.array {
                            if let phoneMessage = phone[0].string {
                                messageArray.append(phoneMessage)
                            } }
                        if let pass = message["password"]?.array {
                            if let pass = pass[0].string {
                                messageArray.append(pass)
                            } } }
                }
                complation(nil, status, messageArray as! [String]);
            }
        }
    }
    
    
    // MARK: - API LOGIN
    class func LoginUser(password: String, email: String, complation : @escaping (_ error : Error? , _ status : Bool? , _ messagesArray: [String] )->Void){
        
        let parameters: [String: String] = [
            "password" : password,
            "email": email
        ]
        var messageArray = [String?]()
        ////http://tech.techno-hat.com/champile/public/api/users/login?email=mohamed-ali@gmail.com&password=123456
        //print (parameters)
        Alamofire.request(loginURL, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                let status = json["status"].bool
                //print("failure")
                messageArray.append("Something gone wrong, please check your internet connection")
                complation(error , status , messageArray as! [String])
                return
            case .success(let value):
                //print("success")
                let json = JSON(value)
                //print(json);
                guard let status = json["status"].bool else { return }
                if !status {
                    /*
                     {
                     "status": false,
                     "message": "Invalid Data"
                     }
                     */
                    if let message = json["message"].string {
                        //print(message)
                        messageArray.append(message);
                    }
                    complation(nil , status , messageArray as! [String]);
                }
                else {
                    /*
                     {
                     "api_token" : "42f9aa7888c982340532634c1c47a63fd160cae4d534861a3bee7c630df6b4bdf39ae667",
                     "status" : true,
                     "user" : {
                     "email" : "a@a.aa",
                     "id" : 8,
                     "image" : null,
                     "updated_at" : "2018-09-17 12:59:07",
                     "created_at" : "2018-09-17 12:58:55",
                     "phone" : "010412df5r6s369",
                     "player_id" : null,
                     "birthday" : null,
                     "username" : "Ahmed"
                     }
                     }
                     */
                    guard let api_Token = json["api_token"].string else { return }
                    Helper.saveIPItoken(apistring: api_Token)
                    DispatchQueue.main.async {
                        ApiMethods.RegisterUserOn_OneSignal()
                    }
                    let userModel = UserModel.init(List: json.dictionary!)
                    messageArray.append("Loged in successfully")
                    //userModel.api_token
                    ReservationDetails.USERDATA = [userModel]
                    //print(userModel.email, userModel.api_token)
                    complation(nil , status , messageArray as! [String]);
                    
                }
            }
        }
    }
    
    // Update User Info
    class func UpdateUser(email : String , phone : String , userName : String , password : String , complation : @escaping (_ error : Error? , _ status : Bool? , _ messagesArray: [String] )->Void){
        let parameters: [String: String] = [
            "email": email,
            "password" : password,
            "username" : userName,
            "phone" : phone,
            "api_token" : Helper.getAPIToken()!
        ]
        var messageArray = [String?]()
        //print (parameters)
        Alamofire.request(updateProfileURL, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                let status = json["status"].bool
                //print("failure", json)
                messageArray.append("Something gone wrong, please check your internet connection")
                complation(error, status, messageArray as! [String])
                return
            case .success(let value):
                print("Successfully")
                let json = JSON(value)
                //print(json)
                guard let status = json["status"].bool else { return }
                if status {
                    if let message = json["message"].string {
                        messageArray.append(message) }
                    
                    /*
                     {
                     "status": true,
                     "api_token_status": true,
                     "message": "Profile updated successfully",
                     "user": {
                     "id": 8,
                     "username": "MohamedAli",
                     "email": "a@a.com",
                     "birthday": "1990-02-10",
                     "image": null,
                     "phone": "01541256369",
                     "player_id": null,
                     "created_at": "2018-09-17 12:58:55",
                     "updated_at": "2018-09-18 12:13:24"
                     }
                     }
                     */
                    guard let user = json.dictionary else { return }
                    let userModel = UserModel.init(List: user)
                    ReservationDetails.USERDATA = [userModel]
                    //print(userModel.email)

                    complation(nil, status, messageArray as! [String]);
                }
                else {
                    /*
                     {
                     "status": false,
                     "message": {
                     "email": [
                     "The email has already been taken."
                     ],
                     "phone": [
                     "The phone has already been taken."
                     ]
                     }
                     }
                     */
                    if let message = json["message"].dictionary {
                        if let email = message["email"]?.array {
                            if let emailMessage = email[0].string {
                                //print(emailMessage)
                                messageArray.append(emailMessage)
                            } }
                        if let phone = message["phone"]?.array {
                            if let phoneMessage = phone[0].string {
                                messageArray.append(phoneMessage)
                            } }
                        if let pass = message["password"]?.array {
                            if let pass = pass[0].string {
                                messageArray.append(pass)
                            } } }
                }
                complation(nil, status, messageArray as! [String]);
            }
        }
    }

    class func RegisterUserOn_OneSignal() {
        let parameters: [String: String] = [
            "api_token" : Helper.getAPIToken()!,
            "player_id" : userToken_OneSignal
        ]
        //print (parameters)
        Alamofire.request(setUserOneSignalToketUrl, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .failure://(let error) :
                //let json = JSON(error)
                
                //print("failure", json)
                
                return
            case .success://(let value):
//                let json = JSON(value)
//                //print(json)
//                guard let status = json["status"].bool else { return }
//                if status { return }
//                else { }
                return
            }
        }
    }
}

