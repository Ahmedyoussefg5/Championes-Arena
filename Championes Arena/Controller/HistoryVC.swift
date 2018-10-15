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
            dataModel.removeAll()
            tableForHistory.reloadData()
            //Get_History_Now()
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

} // Class HistoryVC

extension HistoryVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.00
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellforhistory", for: indexPath) as! CellForHistory
        
        cell.backgroundColor = UIColor.clear
        cell.isOpaque = false
        cell.backgroundView = nil
        
        if type == 1 {
            cell.ConfigureCellforHistory(data: dataModel[indexPath.row])
        }
        else if type == 2 {
            //cell.ConfigureCellforNot(index: indexPath.row)
        }
        return cell
    }
    

}
