//
//  GetDataToTopBar.swift
//  Champione Arena
//
//  Created by Youssef on 9/17/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension ApiMethods {
    
    // MARK: - API GET NEWS
    class func GETNEWS(page: Int = 1, complation : @escaping (_ error : Error?, _ status : Bool?, _ last_page: Int)->Void) {
        
        let UsedURL: String
        switch currentSelectedButton {
        case 1:
            UsedURL = newsURL;
        case 2:
            UsedURL = PlayURL;
        case 3:
            UsedURL = facURL;
        default:
            return
        }
//        let parameters: [String: Any] = [
//            "page": page
//        ]
        let urll = "\(UsedURL)page=\(page)"
        guard let url = URL(string: urll) else { return }
        print(url)
        Alamofire.request(url, method: .get, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                let status = json["status"].bool
                print("failure")
                complation(error , status, page)
                return
            case .success(let value):
                print("success")
                let json = JSON(value)
                //print(json);
                guard let status = json["status"].bool else { return }
                if !status {
                    /*
                     
                     */
//                    if let message = json["message"].string {
//                        print(message)
//                    }
                    /*

                     */
                    complation(nil, status, page);
                }
                else {
                    /*
                     {
                     "status": true,
                     "api_token_status": true,
                     "facilities": {
                     "current_page": 1,
                     "data": [
                     {
                     "id": 2,
                     "title": "The standard chunk of",
                     "content": "bdf.</p>",
                     "image": "40db33947d7cb910abccf4c0e8d6cff3f613a3ad3Art.jpg",
                     "club_id": 1,
                     "created_at": "2018-09-17 01:32:17",
                     "updated_at": "2018-09-17 01:32:17",
                     "files_facility": [
                     {
                     "id": 3,
                     "file": "feabbecf05622f7f64d198c3b6daf0377e752b48How_to_earn_10000_while_learning_to_code_Full.pdf",
                     "facility_id": 2,
                     "created_at": "2018-09-17 01:32:17",
                     "updated_at": "2018-09-17 01:32:17"
                     },
                     {
                     "id": 4,
                     "file": "276f6984101eb7ccd852ddff2b648dc12ca1e707كتاب شرح My SQL.pdf",
                     "facility_id": 2,
                     "created_at": "2018-09-17 01:32:17",
                     "updated_at": "2018-09-17 01:32:17"
                     }
                     ]
                     },
                     {
                     "id": 1,
                     "title": "Where can I get some?",
                     "content": "cxvbc",
                     "image": "71cdd327e293bf1deb120ff03fd4b246ffcda34b18.jpg",
                     "club_id": 1,
                     "created_at": "2018-09-17 01:31:09",
                     "updated_at": "2018-09-17 01:31:09",
                     "files_facility": [
                     {
                     "id": 1,
                     "file": "9c70be63ded7f202d207b2228355630d304fea76JavaScript Level One.pdf",
                     "facility_id": 1,
                     "created_at": "2018-09-17 01:31:09",
                     "updated_at": "2018-09-17 01:31:09"
                     },
                     {
                     "id": 2,
                     "file": "2af62b3c3a0a57d031e6051a0f3cb5351c56338cJavaScript Level Two.pdf",
                     "facility_id": 1,
                     "created_at": "2018-09-17 01:31:09",
                     "updated_at": "2018-09-17 01:31:09"
                     }
                     ]
                     }
                     ],
                     "first_page_url": "http://192.168.0.24/champile/public/api/facilities?page=1",
                     "from": 1,
                     "last_page": 1,
                     "last_page_url": "http://192.168.0.24/champile/public/api/facilities?page=1",
                     "next_page_url": null,
                     "path": "http://192.168.0.24/champile/public/api/facilities",
                     "per_page": 10,
                     "prev_page_url": null,
                     "to": 2,
                     "total": 2
                     }
                     }
                     */
                    var News = [NewsModel]()
                    if let data = json["data"].dictionary {
                        //print("tripss here:-",tripss,"END TRIPS")
                        if let data = data["data"]?.array {
                            for obj in data {
                                //print("Object" , obj)
                                if let obj = obj.dictionary {
                                    let news = NewsModel(List: obj)
                                    News.append(news)
                                    //MAINVC.NewsAll = News
                                }
                            }
                            if page == 1 {
                                
                                MAINVC.NewsAll.removeAll()
                            }
                            MAINVC.NewsAll.append(contentsOf: News)
                        }
                        let last_page = data["last_page"]?.int ?? page
                        complation(nil, status, last_page)
                    }
                }
            }
        }
    }
}
