//
//  NewsDetailsVC.swift
//  Champione Arena
//
//  Created by Youssef on 9/10/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit
import Kingfisher


class NewsDetailsVC: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleTXT: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var content: UITextView!
    
    static var NewsAll = [NewsModel]()
    static var dataNotifications = [DataClass]()
    static var path = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let news1 = NewsDetailsVC.NewsAll
        let news2 = NewsDetailsVC.dataNotifications
        let path = NewsDetailsVC.path
        
        if path == 0 {
            if news1.count > 0 {
                let imgUrl = imgURLnews + NewsDetailsVC.NewsAll[0].image
                let url = URL(string: imgUrl)
                img.kf.setImage(with: url)
                
                titleTXT.text = NewsDetailsVC.NewsAll[0].title
                date.text = NewsDetailsVC.NewsAll[0].created_at
                
                guard let cont = NewsDetailsVC.NewsAll[0].content else { return }
                let contentt = cont.removeTags
                content.text = contentt
                
                return
            } }
        
        if path == 1 {
        if news2.count > 0 {
            
            let imgUrl = imgURLnews + news2[0].image!
            let url = URL(string: imgUrl)
            img.kf.setImage(with: url)
            
            titleTXT.text = news2[0].title
            date.text = news2[0].createdAt
            
            guard let cont = news2[0].content else { return }
            let contentt = cont.removeTags
            content.text = contentt
            
            NewsDetailsVC.path = 0
            } }
    }
    
}
