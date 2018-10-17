//
//  Rigister.swift
//  Champione Arena
//
//  Created by Youssef on 9/16/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

class Rigister {
    
    
   class func online_Reg(name: String, email: String, phone: String, pass: String)
    {
        ApiMethods.RegisterUser(name: name, email: email, phone: phone, password: pass) { (error, status, messagesArray) in
            if error == nil {
                if status == true {
                    //self.toVerify();
                    //self.alertshow(title: "Registered successfully", messages: ["Now verify your phone number by the code you will receive soon."])
                    ProgressHUD.showSuccess(Helper.getMessage(messages: messagesArray))

                    Helper.restartApp()

                } else {
                    //self.alertshow(title: "Error", messages: messagesArray)
                    ProgressHUD.showError(Helper.getMessage(messages: messagesArray))


                }
            } else {
                //self.alertshow(title: "Error", messages: messagesArray)
                ProgressHUD.showError(Helper.getMessage(messages: messagesArray))


            }
        }
    }
    

    

}
