//
//  CellForHistory.swift
//  Champione Arena
//
//  Created by Youssef on 9/2/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

class CellForHistory: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dayT: UILabel!
    @IBOutlet weak var timeT: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet var topConsterin: NSLayoutConstraint!
    
    func ConfigureCellforHistory(data: Booking)  {
        
        topConsterin.constant = 15
        
        title.text = "Booking:#" + String(data.id) + " playground #" + String(data.playgroundID)
        dayT.text = data.date
        timeT.text = data.timeFrom + " - " + data.timeTo
        timeT.textAlignment = .center
        status.text = data.status
        let imgStat = data.status
        switch imgStat {
        case "unconfirmed":
            img.image = UIImage(named: "wait")
        case "canceled":
            img.image = UIImage(named: "cancel")
        case "confirmed":
            img.image = UIImage(named: "confirmed")
        default:
            img.image = UIImage(named: "wait")
        } //"Status Booking:
      //  unconfirmed, canceled, confirmed"
    }
    
    func ConfigureCellforNot(data: Datum) {
        
        topConsterin.constant = 2
        
        title.text = data.title
        dayT.text = data.content
        img.image = drawRectangleOnImage(image: img.image!)
        
        let d = DateConverter.getDateFromString(myDate: data.createdAt!)
        

        timeT.textAlignment = .left
        timeT.text = DateConverter.getTimeFromDate(D: d!)
        status.text = DateConverter.getDateFromDate(D: d!)
        
    }
    
    func drawRectangleOnImage(image: UIImage) -> UIImage {
        let imageSize = image.size
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        
        let point = CGPoint.init(x: 0, y: 0)
        
        image.draw(at: point)
        
        let rectangle = CGRect(x: 0, y: (imageSize.height/2) - 30, width: imageSize.width, height: 60)
        
        UIColor.clear.setFill()
        UIRectFill(rectangle)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    

}
