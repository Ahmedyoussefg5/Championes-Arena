//
//  Login.swift
//  Champione Arena
//
//  Created by Youssef on 9/16/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import Foundation
import UIKit

extension LoginVC {
    
    //let USERDATA = Jsonn.self

    
    class func online_Login(emailorphone: String, password: String)
    {
        ApiMethodsREGandLOGIN.LoginUser(password: password, email: emailorphone) { (error, status, messagesArray) in
            if error == nil {
                if status == true {
                    Alert.showNotice(messagesArray: messagesArray, stringMSG: nil)
                    Helper.restartApp();
                }
                else {
                    Alert.showNotice(messagesArray: messagesArray, stringMSG: nil)
                }
            }
            else {
                //self.alertshow(title: "Error", messages: messagesArray)
                Alert.showNotice(messagesArray: messagesArray, stringMSG: nil)
            }
        }
    
    
    }
    
}
    

