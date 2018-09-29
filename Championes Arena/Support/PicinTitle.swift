//
//  File.swift
//  PoolMeUp
//
//  Created by Youssef on 8/7/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import Foundation
import UIKit
//import SideMenu

extension UIViewController {
    
    public func alertshow(title : String , messages : [String]!)  {
        var MessageContent = ""
        for message in messages {
            MessageContent += message + "\n"
        }
        let alert = UIAlertController(title: title, message: MessageContent, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    public func PicinTitle()
    {
        //let nav = self.navigationController?.navigationBar
        //nav?.barStyle = UIBarStyle.black
        //nav?.tintColor = UIColor.yellow
        //let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        //imageView.contentMode = .scaleAspectFit
        //let image = UIImage(named: "Untitled-1.png")
        //imageView.image = image
        //navigationItem.titleView = imageView
        
        let buttonContainer = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        buttonContainer.backgroundColor = UIColor.clear
        let middleBTN = UIButton(type: .custom)
        middleBTN.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        middleBTN.setBackgroundImage(UIImage(named: "titleLogo.png"), for: .normal)
        buttonContainer.contentMode = .scaleAspectFit
        middleBTN.contentMode = .scaleAspectFit
        middleBTN.addTarget(self, action: #selector(toHome(press:)), for: .touchUpInside)
        middleBTN.showsTouchWhenHighlighted = true
        buttonContainer.addSubview(middleBTN)
        navigationItem.titleView = buttonContainer
        ///
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "greenTopShadow.png")!.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)

    }
    
    @objc func toHome(press:UIPress)
    {
        Helper.restartAppHome();
        print("restart")
        
//        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "themainVC") //as! PassReset
//        self.navigationController!.pushViewController(VC1, animated: true)
        
    }
    
    public func setupSideMenu() {
//        SideMenuManager.default.menuPresentMode = .menuSlideIn
//        let sideMenuRoot = storyboard?.instantiateViewController(withIdentifier: "SideMenuRootVC") as! UISideMenuNavigationController
//        SideMenuManager.default.menuRightNavigationController = sideMenuRoot
//        SideMenuManager.default.menuWidth = view.frame.width / 1.5
//        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: view, forMenu: .left)
//        SideMenuManager.default.menuAddPanGestureToPresent(toView: view)
//        SideMenuManager.default.menuFadeStatusBar = false
    }
}
