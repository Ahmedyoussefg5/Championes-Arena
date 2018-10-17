//
//  NewsModel.swift
//  Champione Arena
//
//  Created by Youssef on 9/17/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import Foundation
import SwiftyJSON



class NewsModel {
    
    var id : Int!
    var title : String!
    var content : String!
    var image : String!
    var created_at : String!
    var filesArray = [String]()
    
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
                } } } } }








