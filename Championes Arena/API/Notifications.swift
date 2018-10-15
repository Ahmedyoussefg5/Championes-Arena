// To parse the JSON, add this file to your project and do:
//
//   let HistoryNoti = try? newJSONDecoder().decode(HistoryNoti.self, from: jsonData)

import Foundation

struct HistoryNoti: Codable {
    let status, apiTokenStatus: Bool?
    let notifications: Notifications?
    
    enum CodingKeys: String, CodingKey {
        case status
        case apiTokenStatus = "api_token_status"
        case notifications
    }
}

struct Notifications: Codable {
    let currentPage: Int?
    let data: [Datum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let nextPageURL: JSONNull?
    let path: String?
    let perPage: Int?
    let prevPageURL: JSONNull?
    let to, total: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

struct Datum: Codable {
    let id: Int?
    let title, content, createdAt, updatedAt: String?
    let type: String?
    let typeID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, title, content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case type
        case typeID = "type_id"
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}










/*
 
 {
 "status": true,
 "api_token_status": true,
 "notifications": {
 "current_page": 1,
 "data": [
 {
 "id": 17,
 "title": "New news",
 "content": "The name of the header to be set.",
 "created_at": "2018-10-15 14:23:15",
 "updated_at": "2018-10-15 14:23:15",
 "type": "news",
 "type_id": 12
 }
 ],
 "first_page_url": "http://192.168.0.27/champile/public/api/notifications?page=1",
 "from": 1,
 "last_page": 1,
 "last_page_url": "http://192.168.0.27/champile/public/api/notifications?page=1",
 "next_page_url": null,
 "path": "http://192.168.0.27/champile/public/api/notifications",
 "per_page": 10,
 "prev_page_url": null,
 "to": 1,
 "total": 1
 }
 }
 
 */

extension ApiMethods {
    
    class func getNotifications(complation : @escaping (_ error : Error? , _ status : Bool? , _ noty: [Datum]?)->Void) {
        guard let api_T = Helper.getAPIToken() else { return }
        let urll = "\(notificationsUrl)api_token=\(api_T)"
        /// http://192.168.0.27/champile/public/api/notifications?api_token=073346d8d4d66ebbb6eb0848f010a30597c51132ce4b9b3e73fdcb33a22e02d9c9abe743
        //var messageArray = [String?]()
        guard let url = URL(string: urll) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do
            {
                let historyNoti = try JSONDecoder().decode(HistoryNoti.self, from: data)
                if historyNoti.status! {
                    //print(times.status)
                    complation(error, true, historyNoti.notifications?.data)
                }
                else {
                    //print(times.status)
                    //messageArray.append(times.message?.date[0])
                    complation(error, false, nil)
                }
            }
            catch let jsonError {
                //messageArray.append("Something gone wrong, please check your internet connection")
                complation(error , false, nil)
                print("§§Error JSONSerialization ", jsonError)    }
            }.resume()
    }
}










