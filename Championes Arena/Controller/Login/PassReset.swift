//
//  PassReset.swift
//  Champione Arena
//
//  Created by Youssef on 8/29/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

class PassReset: UIViewController {

    @IBOutlet weak var resetBTN: UIButton!
    @IBOutlet weak var cancelBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let Yellow_Sky = UIColor(rgb: 0xFCD534)
//        let Yellow_Dark = UIColor(rgb: 0xFAC000)
//        self.resetBTN.applyGradient(colours: [Yellow_Sky, Yellow_Dark])
//        self.cancelBTN.applyGradient(colours: [Yellow_Sky, Yellow_Dark])
//        self.view.applyGradient(colours: [Yellow_Sky,UIColor.black, Yellow_Dark], locations: [0.0, 0.5, 1.0])
    }

    @IBAction func cancelBTN(_ sender: Any) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
        self.navigationController!.pushViewController(VC1, animated: true)
    }
}
