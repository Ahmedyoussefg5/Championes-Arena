//
//  AppDelegate.swift
//  Championes Arena
//
//  Created by Youssef on 9/25/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit
import OneSignal
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        
        /*
         /////////////
         */
        let appID = "b204d604-f22b-4f18-b1e2-d702afafe12c"
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: appID,
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            
            print("User accepted notifications: \(accepted)")
        })
        
        AppDelegate.getUserIdOneSignal()
        
        // Override point for customization after application launch.
        return true
    }
    
    class func getUserIdOneSignal(){
        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
        let userID = status.subscriptionStatus.userId
        print("userID = \(userID ?? "None")")
        
        userToken_OneSignal = userID ?? "None"
    }
}

