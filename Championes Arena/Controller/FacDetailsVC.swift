//
//  FacDetailsVC.swift
//  Champione Arena
//
//  Created by Youssef on 9/10/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit
import WebKit
import PopMenu

class FacDetailsVC: UIViewController, WKNavigationDelegate {
    
    static var NewsAll = [NewsModel]()
    @IBOutlet weak var fileBTN: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleTXT: UILabel!
    @IBOutlet weak var contentTXT: UITextView!
    
    let menuViewController = PopMenuViewController()
    var actionsArr = [PopMenuAction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img.kf.indicatorType = .activity
        let imgUrl = imgURLfac + FacDetailsVC.NewsAll[0].image
        let url = URL(string: imgUrl)
        img.kf.setImage(with: url)
        
        titleTXT.text = FacDetailsVC.NewsAll[0].title
        guard let cont = FacDetailsVC.NewsAll[0].content else { return }
        let content = cont.removeTags
        contentTXT.text = content
        
        addBTNs()
    }
    
    @IBAction func downloadBTN(_ sender: Any) {
        let menu = PopMenuViewController(sourceView: fileBTN, actions: actionsArr)
        present(menu, animated: true, completion: nil)
    }
    
    func openBrowser(url: String) {
        let stringUrll = url.replacingOccurrences(of: " ", with: "%20", options: String.CompareOptions.regularExpression, range: nil)
        guard let url = URL(string: stringUrll) else { return }
        UIApplication.shared.open(url)
    }
    
    func addBTNs ()
    {
        switch FacDetailsVC.NewsAll[0].filesArray.count {
        case 0:
            fileBTN.isHidden = true
            return;
        case 1:
            add5Actions(count: 1)
            return;
        case 2:
            add5Actions(count: 2)
            return;
        case 3:
            add5Actions(count: 3)
            return;
        case 4:
            add5Actions(count: 4)
            return;
        case 5:
            add5Actions(count: 5)
            return;
        default:
            return
        } }
    
    func add5Actions(count: Int)
    {
        
        let action1 = PopMenuDefaultAction(title: FacDetailsVC.NewsAll[0].filesArray[0], didSelect: { action in
            let stringUrl = mainFileurl + FacDetailsVC.NewsAll[0].filesArray[0]
            self.openBrowser(url: stringUrl)
            
            //print("\(String(describing: action.title)) is tapped")
        })
        
        if count == 1 {
            self.actionsArr.append(action1)
            return }
        
        let action2 = PopMenuDefaultAction(title: FacDetailsVC.NewsAll[0].filesArray[1], didSelect: { action in
            let stringUrl = mainFileurl + FacDetailsVC.NewsAll[0].filesArray[1]
            self.openBrowser(url: stringUrl)
            
            //print("\(String(describing: action.title)) is tapped")
        })
        
        if count == 2 {
            self.actionsArr.append(action1)
            self.actionsArr.append(action2)
            return
        }

        let action3 = PopMenuDefaultAction(title: FacDetailsVC.NewsAll[0].filesArray[2], didSelect: { action in
            let stringUrl = mainFileurl + FacDetailsVC.NewsAll[0].filesArray[2]
            self.openBrowser(url: stringUrl)
            
            //print("\(String(describing: action.title)) is tapped")
        })
        
        if count == 3 {
            self.actionsArr.append(action1)
            self.actionsArr.append(action2)
            self.actionsArr.append(action3)
            return }
        
        let action4 = PopMenuDefaultAction(title: FacDetailsVC.NewsAll[0].filesArray[3], didSelect: { action in
            let stringUrl = mainFileurl + FacDetailsVC.NewsAll[0].filesArray[3]
            self.openBrowser(url: stringUrl)
            
            //print("\(String(describing: action.title)) is tapped")
        })
        
        if count == 4 {
            self.actionsArr.append(action1)
            self.actionsArr.append(action2)
            self.actionsArr.append(action3)
            self.actionsArr.append(action4)
            return }

        let action5 = PopMenuDefaultAction(title: FacDetailsVC.NewsAll[0].filesArray[4], didSelect: { action in
            let stringUrl = mainFileurl + FacDetailsVC.NewsAll[0].filesArray[4]
            self.openBrowser(url: stringUrl)
            
            //print("\(String(describing: action.title)) is tapped")
        })
        
        if count == 4 {
            self.actionsArr.append(action1)
            self.actionsArr.append(action2)
            self.actionsArr.append(action3)
            self.actionsArr.append(action5)
            return }
    }
    
}


