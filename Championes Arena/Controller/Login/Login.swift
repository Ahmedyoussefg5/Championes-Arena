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
        ApiMethods.LoginUser(password: password, email: emailorphone) { (error, status, messagesArray) in
            if error == nil {
                if status == true {
                    ProgressHUD.showSuccess(Helper.getMessage(messages: messagesArray))
                    Helper.restartApp();
                }
                else {
                    ProgressHUD.showError(Helper.getMessage(messages: messagesArray))
                }
            }
            else {
                //self.alertshow(title: "Error", messages: messagesArray)
                ProgressHUD.showError(Helper.getMessage(messages: messagesArray))
            }
        }
    
    
    }
    
}
    

