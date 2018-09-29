//
//  CellForNews.swift
//  Champione Arena
//
//  Created by Youssef on 9/1/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

class CellForNews: UITableViewCell {
    
    
    @IBOutlet weak var imgPlayer: UIImageView!
    @IBOutlet weak var lableName: UILabel!
    @IBOutlet weak var lableDate: UILabel!
    @IBOutlet weak var lableDetails: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    func ConfigureCellforNews(index: Int)  {
        let imgUrl = imgURLnews + MAINVC.NewsAll[index].image
        let url = URL(string: imgUrl)
        img.kf.setImage(with: url)
        lableName.text = MAINVC.NewsAll[index].title
        lableDate.text = MAINVC.NewsAll[index].created_at
        
        guard let cont = MAINVC.NewsAll[index].content else { return }
        let content = cont.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        lableDetails.text = content //MAINVC.NewsAll[index].content
    }
    
    func ConfigureCellforBook(index: Int)  {
        let imgUrl = imgURLplay + MAINVC.NewsAll[index].image
        let url = URL(string: imgUrl)
        img.kf.setImage(with: url)
        lableName.text = MAINVC.NewsAll[index].title
        lableDate.text = ""
        
        guard let cont = MAINVC.NewsAll[index].content else { return }
        let content = cont.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        lableDetails.text = content //MAINVC.NewsAll[index].content
        
    }
        
        func ConfigureCellforFac(index: Int)  {
            let imgUrl = imgURLfac + MAINVC.NewsAll[index].image
            let url = URL(string: imgUrl)
            img.kf.setImage(with: url)
            print("-------", url!)
            lableName.text = MAINVC.NewsAll[index].title
            lableDate.text = ""
            
            guard let cont = MAINVC.NewsAll[index].content else { return }
            let content = cont.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
            lableDetails.text = content //MAINVC.NewsAll[index].content
        }
}
