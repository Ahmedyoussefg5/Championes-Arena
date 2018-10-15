//
//  LoginVC.swift
//  Champione Arena
//
//  Created by Youssef on 8/29/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit
//import FacebookLogin

class LoginVC: UIViewController {

    
    @IBOutlet weak var mainORuser: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    @IBOutlet var faceBookV: UIView!
    // MARK: - LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
//    
//    @IBAction func faceBookBTN(_ sender: Any) {
//        let loginManager = LoginManager()
//        
//        loginManager.logIn(readPermissions: [.publicProfile], viewController: self) { loginResult in
//            switch loginResult {
//            case .failed( let error):
//                print(error)
//            case .cancelled:
//                print("User cancelled login.")
//            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
//                print(grantedPermissions, declinedPermissions, accessToken)
//                print("Logged in!")
//            } } }
    
    @IBAction func loginBTN(_ sender: Any) {
        guard let mailORuser = mainORuser.text, !mailORuser.isEmpty, Helper.isValidEmail(usermail: mailORuser) else {
            Alert.showNotice(messagesArray: nil, stringMSG: "Enter A Valid E-Mail")
            return;
        }
        guard let pass = pass.text, !pass.isEmpty, pass.count > 5 else {
            Alert.showNotice(messagesArray: nil, stringMSG: "Enter Your Password")
            return
        }
        
        LoginVC.online_Login(emailorphone: mailORuser, password: pass);
    }
    
    
    @IBAction func forgetBTN(_ sender: Any) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "forgetPassVC") as! PassReset
        self.navigationController!.pushViewController(VC1, animated: true)
    }
    
    @IBAction func createAccBTN(_ sender: Any) {
        let loginSP = UIStoryboard.init(name: "Login_Regster_SB", bundle: nil)
        let VC2 = loginSP.instantiateViewController(withIdentifier: "registerVC") as! RegisterVC
        self.navigationController!.pushViewController(VC2, animated: true)
    }
    
    @IBAction func cancelBTN(_ sender: Any) {
        Helper.restartAppHome()
    }
}
