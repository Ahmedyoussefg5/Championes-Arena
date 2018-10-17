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
    
    lazy var refresher : UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.tintColor = UIColor.init(red: 201, green: 152, blue: 7)
        if type == 1 {
            refresher.addTarget(self, action: #selector(get_History_Now), for: .valueChanged) }
        if type == 2 {
            refresher.addTarget(self, action: #selector(get_Notifications_Now), for: .valueChanged) }
        return refresher
    }()
    
    @IBOutlet weak var tableForHistory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableForHistory.backgroundColor = UIColor.clear
        tableForHistory.isOpaque = false
        tableForHistory.backgroundView = nil
        tableForHistory.tableFooterView = UIView()
        tableForHistory.separatorInset = .zero
        tableForHistory.contentInset = .zero
        tableForHistory.addSubview(refresher)
        
        if type == 1 {
            get_History_Now()
        }
        else if type == 2 {
            get_Notifications_Now()
        }
        print(type)
    }
    
    @objc fileprivate func get_History_Now()
    {
        ApiMethods.getHistory() { (error, status, messagesArray, history) in
            if error == nil {
                if status == true {
                    self.dataModel = history!
                    self.dataModel = self.dataModel.sorted(by: { $0.createdAt > $1.createdAt })
                    DispatchQueue.main.async {
                        self.tableForHistory.reloadData()
                        self.refresher.endRefreshing()
                    }
                }
                else {
                    self.refresher.endRefreshing()
                    ProgressHUD.showError(Helper.getMessage(messages: messagesArray))
                }
            } else {
                self.refresher.endRefreshing()
                ProgressHUD.showError(Helper.getMessage(messages: messagesArray))
            }
        } }
    

    
    
    var isLoading: Bool = false
    var current_page = 1
    var last_page = 1
    @objc fileprivate func get_Notifications_Now() {
        self.refresher.endRefreshing()
        guard !isLoading else { return }
        
        isLoading = true
        ApiMethods.getNotifications { (error, status, notifications, last_page)  in
            self.isLoading = false
            if error == nil {
                if status! {
                    self.dataNotifications = notifications!
                    //self.dataNotifications = self.dataNotifications.sorted(by: { $0.createdAt > $1.createdAt })
                    DispatchQueue.main.async {
                        self.tableForHistory.reloadData()
                    }
                    self.current_page = 1
                    self.last_page = last_page }
                else {
                    ProgressHUD.showError("Network Error")
                }
            }
            else {
                ProgressHUD.showError("Network Error")
            }
        }
    }
    
    
    fileprivate func loadMoreNotifications() {
        guard !isLoading else { return }
        guard current_page < last_page else { return }
        
        isLoading = true
        ApiMethods.getNotifications(page: current_page + 1) { (error, status, notifications, last_page) in
            self.isLoading = false
            if error == nil {
                if status! {
                    for element in notifications! {
                        self.dataNotifications.append(element)
                    }
                    //print(self.dataNotifications)
                    //self.dataNotifications.append(notifications)
                    DispatchQueue.main.async {
                        self.tableForHistory.reloadData()
                    }
                    
                    self.current_page += 1
                    self.last_page = last_page
                }
                else {
                    ProgressHUD.showError("Network Error")
                }
            }
            else {
                ProgressHUD.showError("Network Error")
            }
        }
    }
    
    

    
    
    func getDataForNews(i: Int) {
        ApiMethods.getNotificationsContentForOneNews(id: i) { (error, status, newsData) in
            if error == nil {
                if status == true {
                    //print(newsData!)
                    let NewsDetails: UIViewController
                    let detailsVCsStoryB = UIStoryboard.init(name: "DetailsVCsStoryB", bundle: nil)
                    NewsDetails = detailsVCsStoryB.instantiateViewController(withIdentifier: "newsDetails") as! NewsDetailsVC
                    NewsDetailsVC.dataNotifications.removeAll()
                    NewsDetailsVC.path = 1
                    NewsDetailsVC.dataNotifications.append(newsData![0])
                    currentSelectedButton = 0
                    
                    DispatchQueue.main.async {
                        self.addChildViewController(NewsDetails)
                        self.view.addSubview(NewsDetails.view)
                        NewsDetails.view.frame = self.view.bounds
                        NewsDetails.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        NewsDetails.didMove(toParentViewController: self)
                    }
                }
                else {
                    ProgressHUD.showError("Network Error")
                }
            }
            else {
                ProgressHUD.showError("Network Error")
            } }  }
    
   
    
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
        else { return 115 }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { tableView.deselectRow(at: indexPath, animated: true)
        
        if type == 2 {
            guard let type_News_History = dataNotifications[indexPath.row].type else {
                return  }
            if type_News_History == "news"
            {
                type = 0
                getDataForNews(i: dataNotifications[indexPath.row].typeID!)
            }
            else { type = 1;
                get_History_Now() }
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if type == 2 {
        if indexPath.row == dataNotifications.count - 1 {
            // on the last row
            print("dataNotifications.count",dataNotifications.count)
            self.loadMoreNotifications()
            } }
    }
    
    
}
