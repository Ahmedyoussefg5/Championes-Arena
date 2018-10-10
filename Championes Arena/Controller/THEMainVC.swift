//
//  THEMainVC.swift
//  Champione Arena
//
//  Created by Youssef on 9/6/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

class THEMainVC: UIViewController {
    
    var item = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // LocalNotificationsPushing.shared.recuestAuth();
        
       // LocalNotificationsPushing.shared.sendLocalPush(in: 2)
    }
    
    
    
    
    
    
    
    @IBAction func newsCLK(_ sender: Any) {
        item = 1
        goToMain(cat: item)
    }
    
    @IBAction func bookCLK(_ sender: Any) {
        item = 2
        goToMain(cat: item)
    }
    
    @IBAction func facCLK(_ sender: Any) {
        item = 3
        goToMain(cat: item)
    }
    
    @IBAction func openBrowserBTN(_ sender: Any) {
        guard let url = URL(string: "https://goo.gl/maps/2NmziuudDSR2") else { return }
        UIApplication.shared.open(url)
    }
    
    func goToMain (cat: Int) {
        
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "mainVC") as! MAINVC
        homeVC.currentSelectedButton = cat
        let navigationController = UINavigationController(rootViewController: homeVC)
        self.present(navigationController, animated: true, completion: nil)
    }
    
}

