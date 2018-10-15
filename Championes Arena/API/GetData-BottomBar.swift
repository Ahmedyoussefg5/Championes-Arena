//
//  HistoryAPI.swift
//  Champione Arena
//
//  Created by Youssef on 9/19/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

extension ApiMethods {
    
    class func getHistory(complation : @escaping (_ error : Error? , _ status : Bool? , _ messagesArray: [String]? , _ availbleTimes: [Booking]?)->Void){
        
        //http://tech.techno-hat.com/champions_arena/public/api/bookings_user?api_token=6de57f43895b2fd6bcb1bbdf52842b8db486702c78287af434ec132d527e22a501951f45
        guard let apiT = Helper.getAPIToken() else { return }
        let urll = "\(historyurl)api_token=\(apiT)"
        print(urll)
        var messageArray = [String?]()
        guard let url = URL(string: urll) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do
            {
                let history = try JSONDecoder().decode(History.self, from: data)
                if history.status {
                    print(history.status)
                    complation(error , true , nil, history.bookings)
                }
                else {
                    //                    print(times.status)
                    //                    messageArray.append(History.message?.date.randomElement())
                    //                    complation(error , false , messageArray as? [String] , nil)
                }
            }
            catch let jsonError {
                messageArray.append("Something gone wrong, please check your internet connection")
                complation(error , false , messageArray as? [String] , nil)
                print("§§Error JSONSerialization ", jsonError)    }
            }.resume()
        
        
    }
}



