//
//  SettingsVC.swift
//  Champione Arena
//
//  Created by Youssef on 8/30/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

class MAINVC: UIViewController{
    
    
    @IBOutlet weak var newsBTN: UIButton!
    @IBOutlet weak var bookBTN: UIButton!
    @IBOutlet weak var facilitiesBTN: UIButton!
    @IBOutlet weak var settingsBTN: UIButton!
    @IBOutlet weak var calBTN: UIButton!
    @IBOutlet weak var billBTN: UIButton!
    
    @IBOutlet weak var mainV: UIView!
    @IBOutlet weak var tableForData: UITableView!
    
    static var NewsAll = [NewsModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("BTN, ",currentSelectedButton)
        PicinTitle()
        
        tableForData.backgroundColor = UIColor.clear
        tableForData.isOpaque = false
        tableForData.backgroundView = nil
        tableForData.tableFooterView = UIView()
        tableForData.separatorInset = .zero
        tableForData.contentInset = .zero
        
        tableForData.addSubview(refresher)
        
        getCurrentselectedBTN();
        
        handleRefresh()
    }
    
    lazy var refresher : UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.tintColor = UIColor.init(red: 201, green: 152, blue: 7)
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresher
    }()
    
    var isLoading: Bool = false
    var current_page = 1
    var last_page = 1
    @objc fileprivate func handleRefresh() {
        self.refresher.endRefreshing()
        guard !isLoading else { return }
        
        isLoading = true
        ApiMethods.GETNEWS { (error, status, last_page) in
            self.isLoading = false
            if error == nil {
                if status! {
                    let rang = NSMakeRange(0, self.tableForData.numberOfSections)
                    let sections = NSIndexSet(indexesIn: rang)
                    
                    self.tableForData.reloadSections(sections as IndexSet, with: .fade)
                    
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
    
    
    fileprivate func loadMore() {
        guard !isLoading else { return }
        guard current_page < last_page else { return }
        
        isLoading = true
        ApiMethods.GETNEWS (page: current_page + 1) { (error, status, last_page) in
            self.isLoading = false
            if error == nil {
                if status! {
                    self.tableForData.reloadData()
                    
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
    
    
    @IBAction func signOutBTN(_ sender: Any) {
        Helper.signOut()
    }
    
    @IBAction func newsCLK(_ sender: Any) {
        //if currentSelectedButton != 1 {
        currentSelectedButton = 1
        newsBTN.setBackgroundImage(UIImage(named: "Newsse.png"), for: .normal);
        reset(btn: sender as! UIButton, img: "News.png")
        getNewsTable()
    } //}
    
    @IBAction func bookCLK(_ sender: Any) {
        //if currentSelectedButton != 2 {
        currentSelectedButton = 2
        bookBTN.setBackgroundImage(UIImage(named: "Bookse.png"), for: .normal);
        reset(btn: sender as! UIButton, img: "Book.png")
        getNewsTable()
    } //}
    
    @IBAction func facilitiesCLK(_ sender: Any) {
        //if currentSelectedButton != 3 {
        currentSelectedButton = 3
        facilitiesBTN.setBackgroundImage(UIImage(named: "Facse.png"), for: .normal);
        reset(btn: sender as! UIButton, img: "Fac.png")
        getNewsTable()
    } //}
    
    @IBAction func settingsCLK(_ sender: Any) {
        // if currentSelectedButton != 4 {
        currentSelectedButton = 4
        toNewsDetails_Settings(i: 0)
        settingsBTN.setBackgroundImage(UIImage(named: "settingsse.png"), for: .normal);
        reset(btn: sender as! UIButton, img: "settings.png")
    } //}
    
    @IBAction func calCLK(_ sender: Any) {
        getBookingHistory()
    }
    
    func getBookingHistory() {
        if checkIfRegistered() {
            //  if currentSelectedButton != 5 {
            currentSelectedButton = 5
            getHistory()
            calBTN.setBackgroundImage(UIImage(named: "calenderse.png"), for: .normal);
            reset(btn: calBTN, img: "calender.png")
        } //}
        else {
            let VC2 = self.storyboard!.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
            self.navigationController!.pushViewController(VC2, animated: true)
        }
    }
    
    @IBAction func billCLK(_ sender: Any) {
        // if currentSelectedButton != 6 {
        currentSelectedButton = 6
        getHistory();
        billBTN.setBackgroundImage(UIImage(named: "billImgse.png"), for: .normal);
        reset(btn: sender as! UIButton, img: "billImg.png")
    } //}
    
    public func reset(btn: UIButton, img: String) {
        let dictBTNs: [UIButton: String] = [self.newsBTN: "News.png", self.bookBTN: "Book.png", self.facilitiesBTN: "Fac.png", self.settingsBTN: "settings.png", self.calBTN: "calender.png", self.billBTN: "billImg.png"]
        for i in dictBTNs {
            if (i.value != img) {
                i.key.setBackgroundImage(UIImage(named: i.value), for: .normal)
            } } } //reset func
    
    func getNewsTable()
    {
        if self.childViewControllers.count > 0 {
            let viewControllers:[UIViewController] = self.childViewControllers
            for viewContoller in viewControllers{
                viewContoller.willMove(toParentViewController: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParentViewController()
            } }
        //MAINVC.NewsAll.removeAll()
        handleRefresh()
    }
    
    // Click on cell on Table V
    func toNewsDetails_Settings(i: Int)
    {
        let NewsDetails: UIViewController
        let detailsVCsStoryB = UIStoryboard.init(name: "DetailsVCsStoryB", bundle: nil)
        switch currentSelectedButton {
        case 1:
            NewsDetails = detailsVCsStoryB.instantiateViewController(withIdentifier: "newsDetails") as! NewsDetailsVC
            NewsDetailsVC.NewsAll.removeAll()
            NewsDetailsVC.NewsAll.append(MAINVC.NewsAll[i])
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
            NewsDetails = UIStoryboard.init(name: "BottomBarSB", bundle: nil).instantiateViewController(withIdentifier: "settingsVC") as! SettingsVC
            //NewsDetails = (storyboard?.instantiateViewController(withIdentifier: "settingsVC"))! //as! TableViewVC
        default:
            return }
        
        addChildViewController(NewsDetails)
        self.mainV.addSubview(NewsDetails.view)
        NewsDetails.view.frame = mainV.bounds
        NewsDetails.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        NewsDetails.didMove(toParentViewController: self)
        
        currentSelectedButton = 0
    }
    
    func getHistory()
    {
        let historyVC = UIStoryboard.init(name: "BottomBarSB", bundle: nil).instantiateViewController(withIdentifier: "historyVC") as! HistoryVC
        //storyboard!.instantiateViewController(withIdentifier: "historyVC") as! HistoryVC //mainVC
        
        if checkIfRegistered() {
            switch currentSelectedButton {
            case 5:
                historyVC.type = 1
            case 6:
                historyVC.type = 2
            default:
                return
            } }
        else { historyVC.type = 0 }
        
        if currentSelectedButton != 6 || currentSelectedButton != 5 {
            addChildViewController(historyVC)
            self.mainV.addSubview(historyVC.view)
            historyVC.view.frame = view.bounds
            historyVC.view.frame = mainV.bounds
            historyVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            historyVC.didMove(toParentViewController: self)
        } } //getHistory
    
    func getCurrentselectedBTN() {
        switch currentSelectedButton {
        case 1:
            newsBTN.setBackgroundImage(UIImage(named: "Newsse.png"), for: .normal);
        case 2:
            bookBTN.setBackgroundImage(UIImage(named: "Bookse.png"), for: .normal);
        case 3:
            facilitiesBTN.setBackgroundImage(UIImage(named: "Facse.png"), for: .normal);
        default:
            return
        } } //getCurrentselectedBTN
    
    
    
    func checkIfRegistered () -> Bool {
        
        let def = UserDefaults.standard
        if let api_token = def.object(forKey: "api_token") as? String {
            print (api_token)
            
            return true
        }
        else { return false }
    }
    
}// Class

extension MAINVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MAINVC.NewsAll.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.00 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        toNewsDetails_Settings(i: indexPath.row) }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableForData.dequeueReusableCell(withIdentifier: "cellForNews", for: indexPath) as! CellForNews
        
        cell.backgroundColor = UIColor.clear
        cell.isOpaque = false
        cell.backgroundView = nil
        
        switch currentSelectedButton {
        case 1:
            cell.ConfigureCellforNews(index: indexPath.row)
        case 2:
            cell.ConfigureCellforBook(index: indexPath.row)
        case 3:
            cell.ConfigureCellforFac(index: indexPath.row)
        default:
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == MAINVC.NewsAll.count - 1 {
            // on the last row
            
            self.loadMore()
        }
    }
        
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        //Alert.showNotice(messagesArray: nil, stringMSG: "I was shaked! Hold your phone.")
    }
}

