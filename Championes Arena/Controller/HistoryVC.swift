//
//  HistoryVC.swift
//  Champione Arena
//
//  Created by Youssef on 9/2/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {
    
    var type: Int = 0
    var dataModel = [Booking]()
    var dataNotifications = [Datum]()

    @IBOutlet weak var tableForHistory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableForHistory.backgroundColor = UIColor.clear
        tableForHistory.isOpaque = false
        tableForHistory.backgroundView = nil
        
//        tableForHistory.tableFooterView = UIView()
//        tableForHistory.separatorInset = .zero
//        tableForHistory.contentInset = .zero
        
        if type == 1 {
            Get_History_Now()
        }
        else if type == 2 {
            Get_Notifications_Now()
        }
        print(type)
    }
    
    func Get_History_Now()
    {
        ApiMethods.getHistory() { (error, status, messagesArray, history) in
            if error == nil {
                if status == true {
                    self.dataModel = history!
                    self.dataModel = self.dataModel.sorted(by: { $0.createdAt > $1.createdAt })
                    DispatchQueue.main.async {
                        self.tableForHistory.reloadData()
                    }
                }
                else {
                    Alert.showNotice(messagesArray: messagesArray, stringMSG: nil) }
            } else {
                Alert.showNotice(messagesArray: messagesArray, stringMSG: nil) }
        } }
    
    func Get_Notifications_Now()
    {
        ApiMethods.getNotifications() { (error, status, notifications) in
            if error == nil {
                if status == true {
                    self.dataNotifications = notifications!
                    //self.dataNotifications = self.dataNotifications.sorted(by: { $0.createdAt > $1.createdAt })
                    DispatchQueue.main.async {
                        self.tableForHistory.reloadData()
                    }
                }
                else {
                    Alert.showNotice(messagesArray: nil, stringMSG: "Error Happened, Try Again Later.") }
            } else {
                Alert.showNotice(messagesArray: nil, stringMSG: "Error With Connection, Try Again Later.") }
        } }
    
    func toNewsDetails_Settings(i: Int)
    {
        let NewsDetails: UIViewController
        let detailsVCsStoryB = UIStoryboard.init(name: "DetailsVCsStoryB", bundle: nil)
        switch currentSelectedButton {
        case 1:
            NewsDetails = detailsVCsStoryB.instantiateViewController(withIdentifier: "newsDetails") as! NewsDetailsVC
            NewsDetailsVC.NewsAll.removeAll()
            NewsDetailsVC.NewsAll.append(MAINVC.NewsAll[i])
        //print(a.indexx)
        case 2:
            NewsDetails = detailsVCsStoryB.instantiateViewController(withIdentifier: "bookDetails") as! ReservationDetails
            ReservationDetails.NewsAll.removeAll()
            ReservationDetails.NewsAll.append(MAINVC.NewsAll[i])
            ReservationDetails.id = i
        case 3:
            NewsDetails = detailsVCsStoryB.instantiateViewController(withIdentifier: "facDetails") as! FacDetailsVC
            FacDetailsVC.NewsAll.removeAll()
            FacDetailsVC.NewsAll.append(MAINVC.NewsAll[i])
        case 4:
            NewsDetails = (storyboard?.instantiateViewController(withIdentifier: "settingsVC"))! //as! TableViewVC
        default:
            return }
        
        addChildViewController(NewsDetails)
        self.view.addSubview(NewsDetails.view)
        NewsDetails.view.frame = view.bounds
        NewsDetails.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        NewsDetails.didMove(toParentViewController: self)
        
        currentSelectedButton = 0
    }

} // Class HistoryVC

extension HistoryVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if type == 1 { return dataModel.count }
         else { return dataNotifications.count }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if type == 1 {
            return 140.00 }
        else { return 125 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellforhistory", for: indexPath) as! CellForHistory
        
        cell.backgroundColor = UIColor.clear
        cell.isOpaque = false
        cell.backgroundView = nil
        
        if type == 1 {
            cell.selectionStyle = .none
            cell.ConfigureCellforHistory(data: dataModel[indexPath.row])
        }
        else if type == 2 {
            cell.ConfigureCellforNot(data: dataNotifications[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // call api

    }
    

}
