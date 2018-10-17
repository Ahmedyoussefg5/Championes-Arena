//
//  Register.swift
//  Champione Arena
//
//  Created by Youssef on 8/29/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var nameTXT: UITextField!
    @IBOutlet weak var emailTXT: UITextField!
    @IBOutlet weak var mobileTXT: UITextField!
    @IBOutlet weak var pass1: UITextField!
    @IBOutlet weak var pass2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        
    }
    
    // MARK: - BUTTON REGISTER
    @IBAction func registerBTN(_ sender: Any) {
        
        guard let name = nameTXT.text, !name.isEmpty else {
            ProgressHUD.showError("Enter Your Name")
            //Alert.showNotice(messagesArray: nil, stringMSG: "Enter Your Name" )
            return }
        guard let email = emailTXT.text, !email.isEmpty, Helper.isValidEmail(usermail: email) else {
            ProgressHUD.showError("Enter Valid E-Mail")
            //Alert.showNotice(messagesArray: nil, stringMSG: "Enter Valid E-Mail" )
            return }
        guard let mobile = mobileTXT.text, !mobile.isEmpty else {
            ProgressHUD.showError("Enter Your Mobile")
            //Alert.showNotice(messagesArray: nil, stringMSG: "Enter Your Mobile" )
            return }
        guard let pass = pass1.text, !pass.isEmpty, pass.count > 5 else {
            ProgressHUD.showError("Enter Your Password")
            //Alert.showNotice(messagesArray: nil, stringMSG: "Enter Your Password" )
            return }
        
        if pass == pass2.text {
            Rigister.online_Reg(name: name, email: email, phone: mobile, pass: pass)
        } else {
            ProgressHUD.showError("Password Fildes Are Not Equal")
            //Alert.showNotice(messagesArray: nil, stringMSG: "Password Fildes Are Not Equal" )
            return }
    }
    
    // MARK: - BUTTON CANCEL
    @IBAction func cancelBTN(_ sender: Any) {
//        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
//        self.navigationController!.pushViewController(VC1, animated: true)
        Helper.restartAppHome()
    }
    
    
}
