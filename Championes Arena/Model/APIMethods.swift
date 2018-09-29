//
//  APIMethods.swift
//  Champione Arena
//
//  Created by Youssef on 9/9/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import Foundation

struct User: Decodable {
    let status: Bool
    let api_token_status: Bool
    let trips: trips
}

struct trips: Decodable {
    let current_page: Int
    let data: [data]
   
 
}

struct data: Decodable {
    let id: Int
    let pick_up_longitude: String!
    let pick_up_latitude: String!
    let pick_off_longitude: String!
    let pick_off_latitude: String!
    let time_start: String!
    let time_end: String!
    let fare_total: String!
    let total_distance: String!
    let address_pick_up: String!
    let address_pick_off: String!
    let accept: Int!
    let date: String!
    
    /*
     "day": null,
     "driver_id": 4,
     "remember_token": null,
     "created_at": "2018-07-04 02:37:43",
     "updated_at": "2018-07-04 02:37:43",
     "points_trip": [
     {
     "id": 8,
     "longitude": "31.3269754",
     "latitude": "30.1521193",
     "address": "Al Marj\r\nالمرج",
     "trip_id": 61,
     "active": "1",
     "created_at": "2018-07-03 15:00:00",
     "updated_at": "2018-07-03 15:00:00"
     },
     {
     "id": 9,
     "longitude": "31.2940322",
     "latitude": "30.0986658",
     "address": "Al Qubbaah Palace\r\nقصر القبة",
     "trip_id": 61,
     "active": "1",
     "created_at": "2018-07-03 15:00:00",
     "updated_at": "2018-07-03 15:00:00"
     }
     ]
     },
     */
    
    /*
     {
     "api_token" : "42f9aa7888c982340532634c1c47a63fd160cae4d534861a3bee7c630df6b4bdf39ae667",
     "status" : true,
     "user" : {
     "email" : "a@a.aa",
     "id" : 8,
     "image" : null,
     "updated_at" : "2018-09-17 12:59:07",
     "created_at" : "2018-09-17 12:58:55",
     "phone" : "010412df5r6s369",
     "player_id" : null,
     "birthday" : null,
     "username" : "Ahmed"
     }
     }
     */
}

class ParseUserData {
    
   class func getUser () {
        let _url = "http://tech.techno-hat.com/poolme/public/api/passenger/alltrip?api_token=68c017611be4c7a7e159f37f9a5fecd3"
        guard let url = URL(string: _url) else { return }
    
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            do
            {
                let user = try JSONDecoder().decode(User.self, from: data)
                print("User :- ", user.trips.data[1].id)
            }
            catch let jsonError {
                print("§§Error JSONSerialization ", jsonError)    }
        }.resume()
    }

}
