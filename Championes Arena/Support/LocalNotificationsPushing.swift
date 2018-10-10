//
//  LocalNotificationsPushing.swift
//  Championes Arena
//
//  Created by Youssef on 10/9/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationsPushing: NSObject {
    
    
    static var shared = LocalNotificationsPushing();
    let center = UNUserNotificationCenter.current()
    
    func recuestAuth() {
        
        center.requestAuthorization(options: [.alert, .sound]) { (bool, error) in
            if bool == true {
                if error == nil {
                    print("Granted Permission")
                } }
        }
    }
    
    func sendLocalPush (in time: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Hello!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Hello i'm here", arguments: nil)
        content.sound = UNNotificationSound.default()
        
        // Deliver the notification.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
        // Schedule the notification.
        //let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if error == nil {
                print("Push Succeed")
            }else {
                print("Error in push notifications")
            } }
    }
}


