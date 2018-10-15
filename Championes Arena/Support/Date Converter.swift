//
//  File.swift
//  PoolMeUp
//
//  Created by Youssef on 8/8/18.
//  Copyright © 2018 Youssef. All rights reserved.
//
import UIKit
import Foundation

class DateConverter: NSObject{
    
    class func getDateFromString(myDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: myDate) // replace Date String
    }
    
    class func getDateToString (date: Date) -> String
    {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let myString = formatter.string(from: date)
        let Date = formatter.date(from: myString)
        formatter.dateFormat = "yyyy-MM-dd"
        //formatter.dateFormat = "dd-MMM-yyyy"
        let myStringafd = formatter.string(from: Date!)
        //print("pik date is ", myStringafd)
        return myStringafd
        
    }
    
    class func getTimeFromDate(D: Date) -> String{
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: D)
        let minutes = calendar.component(.minute, from: D)
        let secs = calendar.component(.second, from: D)
        return "\(hour):\(minutes):\(secs)"
    }
    class func getDateFromDate(D: Date) -> String{
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: D)
        let month = calendar.component(.month, from: D)
        let day = calendar.component(.day, from: D)
        return "\(day):\(month):\(year)"
    }
}









