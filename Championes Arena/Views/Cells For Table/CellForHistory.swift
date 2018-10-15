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
    
    func ConfigureCellforHistory(data: Booking)  {
        title.text = "Booking:#" + String(data.id) + " playground #" + String(data.playgroundID)
        dayT.text = data.date
        timeT.text = data.timeFrom + " - " + data.timeTo
        timeT.textAlignment = .center
        status.text = data.status
        let imgStat = data.status
        switch imgStat {
        case "wait":
            img.image = UIImage(named: "wait")
        case "cancel":
            img.image = UIImage(named: "cancel")
        case "done":
            img.image = UIImage(named: "confirmed")
        default:
            return
        } // wait, cancel, done
    }

    func ConfigureCellforNot(index: Int) {
        title.text = "Your booking #1001: is confimed in "
        dayT.text = "Playgroung #1";
        timeT.text = "1-9-2018"
        timeT.textAlignment = .left
        status.text = "10:00 AM - 11:00 AM"

        //img.image = nil
        
       let newIMG = drawRectangleOnImage(image: img.image!)
        
        img.image = newIMG
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
