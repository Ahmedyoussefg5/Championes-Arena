//
//  ReservationDetails.swift
//  Champione Arena
//
//  Created by Youssef on 9/1/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

class ReservationDetails: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleTXT: UILabel!
    
    static var NewsAll = [NewsModel]()
    static var id: Int = 0
    var selectedTimes = [String]()
    
    @IBOutlet weak var selectDateBTN: UIButton!
    @IBOutlet weak var tableForTimes: UITableView!
    @IBOutlet weak var tableForTimes2: UITableView!
    
    static var USERDATA = [UserModel]()
    var availableTimes = [String]()
    var unconfirmedTimes = [String]()
    var day = dayToday
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableForTimes.backgroundColor = UIColor.clear
        tableForTimes.isOpaque = false
        tableForTimes.backgroundView = nil
        tableForTimes.delegate = self
        tableForTimes.dataSource = self
        
        tableForTimes2.backgroundColor = UIColor.clear
        tableForTimes2.isOpaque = false
        tableForTimes2.backgroundView = nil
        tableForTimes2.delegate = self
        tableForTimes2.dataSource = self
        
        let imgUrl = imgURLplay + ReservationDetails.NewsAll[0].image
        let url = URL(string: imgUrl)
        img.kf.setImage(with: url)
        titleTXT.text = ReservationDetails.NewsAll[0].title
        
        print(day)
        
        selectDateBTN.setTitle(DateConverter.getDateToString(date: day), for: .normal)
        Get_Times_Now()
    }
    
    
    @IBAction func selectDateBTNCLK(_ sender: Any) {
        datePickerTapped()
    }
    
    func datePickerTapped() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = 5
        let aYear = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: UIColor.init(red: 201, green: 152, blue: 7),
                                          buttonColor: UIColor.init(red: 201, green: 152, blue: 7),
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show("Pickup your day",
                        doneButtonTitle: "Pick",
                        cancelButtonTitle: "Cancel",
                        minimumDate: currentDate,
                        maximumDate: aYear,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                self.day = dt
                                self.selectDateBTN.titleLabel?.text = DateConverter.getDateToString(date: dt)
                                dayToday = self.day
                                self.Get_Times_Now()
                                print("dt", self.day , dt)
                            } } }
    
    func Get_Times_Now()
    {
        guard let id = ReservationDetails.NewsAll[0].id else { return }
        ApiMethods.getTimes(playground_id: id, date: DateConverter.getDateToString(date: day)) { (error, status, messagesArray, availbleTimes, unconfirmedTimes) in
            if error == nil {
                if status == true {
                    self.availableTimes = availbleTimes!
                    //print("-------------",self.availableTimes)
                    self.unconfirmedTimes = unconfirmedTimes!
                    DispatchQueue.main.async {
                        self.tableForTimes.reloadData()
                        self.tableForTimes2.reloadData()
                    }
                }
                else {
                    ProgressHUD.showError(Helper.getMessage(messages: messagesArray))
                }
            } else {
                ProgressHUD.showError(Helper.getMessage(messages: messagesArray)) }
        }
    }
    
    @IBAction func cancelAndConfirm(_ sender: AnyObject) {
        
        if selectedCells11.count == 0 {
            if selectedCells22.count == 0 {
                ProgressHUD.showError("Choose Times first!")
                return; } }
        
        selectedTimes.removeAll()
        for i in selectedCells11 {
            selectedTimes.append(availableTimes[i])
        }
        for i in selectedCells22 {
            selectedTimes.append(unconfirmedTimes[i])
        }
        
        let stringMSG = selectedTimes.joined(separator: " - ")
        print(stringMSG)
        
        _ = SweetAlert().showAlert("Are you sure you wanna book?", subTitle: stringMSG, style: AlertStyle.warning, buttonTitle:"NO", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "YES", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                _ = SweetAlert().showAlert("Cancelled!", subTitle: "Wish you book next time.", style: AlertStyle.error)
                
            }
            else {
                if self.checkIfRegistered ()
                {
                    self.book_Times_Now ();
                    self.Get_Times_Now ();
                }
                else {
                    _ = SweetAlert().showAlert("Your are not member yet!", subTitle: "Join us now or sign in if allready registered.", style: AlertStyle.warning, buttonTitle:"Cancel", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "OK", otherButtonColor: UIColor.colorFromRGB(0x566C44)) { (isOtherButton) -> Void in
                        if isOtherButton == true {
                        }
                        else {
                            self.goToLoginPage()
                        } } } // else
            }
        }
    }
    
    func book_Times_Now()
    {
        print(selectedTimes)
        let api = Helper.getAPIToken()
        guard let id = ReservationDetails.NewsAll[0].id else { return }
        
        ApiMethods.BookTimes(api_token: api!, date: DateConverter.getDateToString(date: day), playground_id: id, times: selectedTimes) { (error, status, messagesArray)  in
            if error == nil {
                if status == true {
                    selectedCells11.removeAllIndexes();
                    selectedCells22.removeAllIndexes();
                    self.selectedTimes.removeAll();
                    self.tableForTimes.reloadData()
                    self.tableForTimes2.reloadData()
                    
                   // _ = SweetAlert().showAlert("Booked", subTitle: messagesArray![0], style: AlertStyle.success)
                    
                    ProgressHUD.showSuccess("Booked successfully, please confirm your booking by actual payment.")

                }
                else {
                   // _ = SweetAlert().showAlert("Error happend", subTitle: messagesArray![0], style: AlertStyle.success)
                    ProgressHUD.showError(messagesArray![0])
                } }
            else {
               // _ = SweetAlert().showAlert("Error happend", subTitle: messagesArray![0], style: AlertStyle.success)
                ProgressHUD.showError(messagesArray![0])
            }
        }
    }
    
    func goToLoginPage () {
        let loginSP = UIStoryboard.init(name: "Login_Regster_SB", bundle: nil)
        let VC1 = loginSP.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
        self.navigationController!.pushViewController(VC1, animated: true)
    }
    
    func checkIfRegistered () -> Bool {
        
        let def = UserDefaults.standard
        if let api_token = def.object(forKey: "api_token") as? String {
            print (api_token)
            
            return true
        }
        else { return false }
    }
    
    
    
} // Class ResD

extension ReservationDetails: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {  return 1  }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableForTimes
        { return availableTimes.count }
        else { return unconfirmedTimes.count }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {  return 40.00  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == tableForTimes {
            var accessory = UITableViewCellAccessoryType.none
            
            if selectedCells11.contains(indexPath.row) {
                selectedCells11.remove(indexPath.row)
            } else {
                selectedCells11.add(indexPath.row)
                accessory = .checkmark }
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = accessory } }
        
        if tableView == tableForTimes2 {
            var accessory = UITableViewCellAccessoryType.none
            
            if selectedCells22.contains(indexPath.row) {
                selectedCells22.remove(indexPath.row)
            } else {
                selectedCells22.add(indexPath.row)
                accessory = .checkmark }
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = accessory } }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = UIColor.clear
        cell.isOpaque = false
        cell.backgroundView = nil
        
        if tableView == tableForTimes {
            var accessory = UITableViewCellAccessoryType.none
            if selectedCells11.contains(indexPath.row) {
                accessory = .checkmark
            }; cell.accessoryType = accessory }
        
        if tableView == tableForTimes2 {
            var accessory = UITableViewCellAccessoryType.none
            if selectedCells22.contains(indexPath.row) {
                accessory = .checkmark
            }; cell.accessoryType = accessory }
        
        if tableView == tableForTimes {
            cell.textLabel?.text = availableTimes[indexPath.row]
            return cell
        }
        else if tableView == tableForTimes2 {
            cell.textLabel?.text = unconfirmedTimes[indexPath.row]
            //print(unconfirmedTimes)
            return cell
        }
        return cell
    }
}
