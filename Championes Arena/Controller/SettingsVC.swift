//
//  SettingsVC.swift
//  Champione Arena
//
//  Created by Youssef on 9/10/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit
import PopupDialog
import QuartzCore

class SettingsVC: UIViewController {
    
    @IBOutlet weak var signoutBTN: UIButton!
    @IBOutlet weak var rate_BTN: UIButton!
    @IBOutlet weak var send_msgBTN: UIButton!
    @IBOutlet weak var saveBTN: UIButton!
    @IBOutlet weak var nameTXT: UITextField!
    @IBOutlet weak var mailTXT: UITextField!
    @IBOutlet weak var phoneTXT: UITextField!
    @IBOutlet weak var passTXT: UITextField!
    
    
    
    @IBOutlet var saveconstrant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printData()

    }
    
    @IBAction func contactUsBTN(_ sender: Any) {
        _ = SweetAlert().showAlert("", subTitle: "", style: AlertStyle.customImage(imageFile: "phone.png"), buttonTitle: "Cancel", action: { (true) in
            
            print("call NOW 📞 Cancel")
            
            //guard let number = URL(string: "tel://" + "+201024366300") else { return }
            //UIApplication.shared.open(number)
        })
    }
    
    @IBAction func rateUSBTN(_ sender: Any) {
        showCustomDialog(animated: true)
    }
    
    @IBAction func sendMsg(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let textView = UITextView()
        textView.textColor = UIColor.white
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let controller = UIViewController()
        textView.frame = controller.view.frame
        controller.view.addSubview(textView)
        
        alert.setValue(controller, forKey: "contentViewController")
        
        let send = UIAlertAction(title: "Send", style: .default) { (action) in
            let mes = textView.text
            if mes != "" {
                self.sendMessage(messageE: mes!) }
                else {
                ProgressHUD.showError("Enter Your Message First.")
            } }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.height * 0.6)
        alert.view.addConstraint(height)
        
        alert.addAction(send)
        alert.addAction(cancel)
        
        textView.backgroundColor = UIColor.darkGray //0.00, 0.24, 0.97, 0.21
        alert.view.tintColor = UIColor.init(red: 201, green: 152, blue: 7)
        
        present(alert, animated: true, completion: nil)
        if let visualEffectView = alert.view.searchVisualEffectsSubview()
        {
            visualEffectView.effect = UIBlurEffect(style: .dark)
        }
    }
    
    @IBAction func saveBTN(_ sender: Any) {
        SaveNow()
    }
    
    @IBAction func signOtuBTN_Register(_ sender: Any) {
        if checkIfRegistered() {
            //Helper.signOut()
            UserDefaults.standard.removeObject(forKey: "api_token")
            UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseIn, animations: {
                self.viewDidLoad()
            })
        }
        else {
            let loginSP = UIStoryboard.init(name: "Login_Regster_SB", bundle: nil)
            let VC1 = loginSP.instantiateViewController(withIdentifier: "registerVC") as! RegisterVC
            self.navigationController!.pushViewController(VC1, animated: true)
            
            //let VC2 = self.storyboard!.instantiateViewController(withIdentifier: "registerVC") as! RegisterVC
            //self.navigationController!.pushViewController(VC2, animated: true)
        } }
    
    @IBOutlet var bottomStack: UIStackView!
    func printData() {
        if !checkIfRegistered() {
            //Alert.showNotice(messagesArray: nil, stringMSG: "Your Are Not Signed in")
            nameTXT.text = ""
            nameTXT.placeholder = "E-mail"
            mailTXT.text = ""
            mailTXT.placeholder = "Password"
            mailTXT.isSecureTextEntry = true
            phoneTXT.isHidden = true
            passTXT.isHidden = true
            saveBTN.setTitle("Login", for: .normal)
            signoutBTN.setTitle("Register", for: .normal)
            rate_BTN.isHidden = true
            send_msgBTN.isHidden = true
            saveconstrant.constant = -55
            
            /// Top stackHight.multiplier = 0.17
            //            var topConstraint: NSLayoutConstraint
            //            topConstraint = self.stackHight.constraintWithMultiplier(0.175)
            //            self.view!.removeConstraint(self.stackHight)
            //            self.view!.addConstraint(topConstraint)
            //self.view!.layoutIfNeeded()
            
            
            /// buttomStack.multiplier = 0.145
            //            var bottomConstraint: NSLayoutConstraint
            //            bottomConstraint = self.buttomStack.constraintWithMultiplier(0.1)
            //            self.view!.removeConstraint(self.buttomStack)
            //            self.view!.addConstraint(bottomConstraint)
            //            self.view!.layoutIfNeeded()
            return }
        
        let def = UserDefaults.standard
        nameTXT.text = def.object(forKey: "username") as? String
        mailTXT.text = def.object(forKey: "email") as? String
        phoneTXT.text = def.object(forKey: "phone") as? String
    }
    
    func SaveNow() {
        if checkIfRegistered() {
            updateData()
            return }
        else {
            login_now()
        } }
    
    func checkIfRegistered () -> Bool {
        
        let def = UserDefaults.standard
        if let api_token = def.object(forKey: "api_token") as? String {
            print (api_token)
            
            return true
        }
        else { return false }
    }
    
    func updateData()
    {
        guard let name = nameTXT.text, !name.isEmpty else {
            ProgressHUD.showError("Enter Your Name")
            //Alert.showNotice(messagesArray: nil, stringMSG: "Enter Your Name" )
            return;
        }
        guard let email = mailTXT.text, !email.isEmpty, Helper.isValidEmail(usermail: email) else {
            ProgressHUD.showError("Enter Valid E-Mail")
            //Alert.showNotice(messagesArray: nil, stringMSG: "Enter Valid E-Mail" )
            return;
        }
        guard let mobile = phoneTXT.text, !mobile.isEmpty else {
            ProgressHUD.showError("Enter Your Mobile")
            //Alert.showNotice(messagesArray: nil, stringMSG: "Enter Your Mobile" )
            return;
        }
        guard let pass = passTXT.text, !pass.isEmpty, pass.count > 5 else {
            ProgressHUD.showError("Enter Your Password more than 5 chars")
            //Alert.showNotice(messagesArray: nil, stringMSG: "Enter Your Password more than 5 chars" )
            return;
        }
        
        ApiMethods.UpdateUser(email: email, phone: mobile, userName: name, password: pass) { (error, status, messagesArray) in
            if error == nil {
                if status == true {
                    ProgressHUD.showSuccess(Helper.getMessage(messages: messagesArray))
                    //Alert.showNotice(messagesArray: messagesArray, stringMSG: nil)
                    
                } else {
                    ProgressHUD.showError(Helper.getMessage(messages: messagesArray))
                    //Alert.showNotice(messagesArray: messagesArray, stringMSG: nil)
                }
            } else {
                ProgressHUD.showError(Helper.getMessage(messages: messagesArray))
                //Alert.showNotice(messagesArray: messagesArray, stringMSG: nil)
            } } }
    
    func login_now()
    {
        guard let mailORuser = nameTXT.text, !mailORuser.isEmpty, Helper.isValidEmail(usermail: mailORuser) else {
            ProgressHUD.showError("Enter A Valid E-Mail")
            return }
        guard let pass = mailTXT.text?.trimmedOutput, !pass.isEmpty, pass.count > 5 else {
            ProgressHUD.showError("Enter Your Password")
            return;
        }
        LoginVC.online_Login(emailorphone: mailORuser, password: pass)
    }
    
    func showCustomDialog(animated: Bool = true) {
        let ratingVC = RatingViewController(nibName: "RatingViewController", bundle: nil)
        let popup = PopupDialog(viewController: ratingVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        let buttonOne = CancelButton(title: "CANCEL", height: 50) {
            //"You canceled the rating dialog"
        }
        let buttonTwo = DefaultButton(title: "RATE", height: 50) {
            
            self.submitRate(rate: Int(ratingVC.cosmosStarRating.rating), comment: ratingVC.commentTextField.text!)
        }
        buttonTwo.titleColor = UIColor.init(red: 201, green: 152, blue: 7)
        popup.addButtons([buttonOne, buttonTwo])
        
        present(popup, animated: animated, completion: nil)
    }
    
    func submitRate(rate: Int, comment: String)
    {
        ApiMethods.rate_(rate: rate, comment: comment) { (error, status, done) in
            if error == nil {
                if status! {
                    if done {
                        //Alert.showNotice(messagesArray: nil, stringMSG: "Successfully Submitted.")
                        ProgressHUD.showSuccess("Successfully Submitted.")
                    }
                    else {
                       // Alert.showNotice(messagesArray: nil, stringMSG: ")
                        ProgressHUD.showSuccess("You Have Submitted Before.")

                    }
                    }
                else {
                    ProgressHUD.showError("Error Happened, Try Again Later.") }
                } else {
                    //Alert.showNotice(messagesArray: nil, stringMSG: "Error Happened, Try Again Later.") }
                ProgressHUD.showError("Error Happened, Try Again Later.")
            } } }
    
    func sendMessage(messageE: String)
    {
        ApiMethods.sendMessage(message: messageE) { (error, status, messageArray) in
            if error == nil {
                if status! {
                    ProgressHUD.showSuccess("Successfully Submitted.")
                } else {
                    ProgressHUD.showError("Error Happened, Try Again Later.") }
                }
            else {
                ProgressHUD.showError("Error Happened, Try Again Later.")
            } } }
    
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}


