//
//  NewsDetailsVC.swift
//  Champione Arena
//
//  Created by Youssef on 9/10/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit
import  Kingfisher


class NewsDetailsVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleTXT: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var content: UITextView!
    
    static var NewsAll = [NewsModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgUrl = imgURLnews + NewsDetailsVC.NewsAll[0].image
        let url = URL(string: imgUrl)
        img.kf.setImage(with: url)
        
        titleTXT.text = NewsDetailsVC.NewsAll[0].title
        date.text = NewsDetailsVC.NewsAll[0].created_at
        //content.text = NewsDetailsVC.NewsAll[0].content
        
        guard let cont = NewsDetailsVC.NewsAll[0].content else { return }
        let contentt = cont.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        content.text = contentt
    }

}
