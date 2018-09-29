//
//  NewsModel.swift
//  Champione Arena
//
//  Created by Youssef on 9/17/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import Foundation
import SwiftyJSON



class HistoryModel {
    
    var id : Int!
    var title : String!
    var content : String!
    var image : String!
    var created_at : String!
    var filesArray = [String]()
    
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
    
    init(List : [String : JSON]) {
        
        if let id = List["id"]?.int {
            self.id = id }
        if let title = List["title"]?.string {
            self.title = title }
        if let content = List["content"]?.string {
            self.content = content }
        if let image = List["image"]?.string {
            self.image = image }
        if let created_at = List["created_at"]?.string {
                self.created_at = created_at }
        if let files_facility = List["files_facility"]?.array {
            for item in files_facility {
                if let file = item.dictionary {
                    if let filePath = file["file"]?.string {
                        self.filesArray.append(filePath);
                    }
                    print(filesArray)
                }
            }
        }
        
        
    }
}








