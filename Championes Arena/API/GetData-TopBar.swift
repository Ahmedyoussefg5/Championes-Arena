//
//  GetDataToTopBar.swift
//  Champione Arena
//
//  Created by Youssef on 9/17/18.
//  Copyright © 2018 Youssef. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

class ApiMethodsTopBar {
    
    // MARK: - API GET NEWS
    class func GETNEWS(x: Int, complation : @escaping (_ error : Error?, _ status : Bool?)->Void) {
        
        let UsedURL: String
        switch x {
        case 1:
            UsedURL = newsURL;
        case 2:
            UsedURL = PlayURL;
        case 3:
            UsedURL = facURL;
        default:
            return
        }
        Alamofire.request(UsedURL, method: .get, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                let status = json["status"].bool
                print("failure")
                complation(error , status)
                return
            case .success(let value):
                print("success")
                let json = JSON(value)
                //print(json);
                guard let status = json["status"].bool else { return }
                if !status {
                    /*
                     
                     */
                    if let message = json["message"].string {
                        print(message)
                    }
                    /*

                     */
                    complation(nil, status);
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
                     "content": "<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using &#39;Content here, content here&#39;, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for &#39;lorem ipsum&#39; will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>",
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
                     "content": "<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don&#39;t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn&#39;t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary</p>",
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
                                    //print(trip)
                                    News.append(news)
                                    //print(News)
                                    MAINVC.NewsAll = News
                                    //print("trips",tripss)
                                }
                                //print("trips",tripss)
                            }
                        }
                    }
                    complation(nil, status);
                }
            }
        }
    }
}
