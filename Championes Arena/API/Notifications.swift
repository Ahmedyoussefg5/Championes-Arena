// To parse the JSON, add this file to your project and do:
//
//   let HistoryNoti = try? newJSONDecoder().decode(HistoryNoti.self, from: jsonData)

import Foundation

struct HistoryNoti: Codable {
    let status: Bool?
    let apiTokenStatus: Bool?
    let notifications: Notifications?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case apiTokenStatus = "api_token_status"
        case notifications = "notifications"
    }
}

struct Notifications: Codable {
    let currentPage: Int?
    let data: [Datum]?
    let firstPageURL: String?
    let from: Int?
    let lastPage: Int?
    let lastPageURL: String?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to: Int?
    let total: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data = "data"
        case firstPageURL = "first_page_url"
        case from = "from"
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path = "path"
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to = "to"
        case total = "total"
    }
}

struct Datum: Codable {
    let id: Int?
    let title: String?
    let content: String?
    let createdAt: String?
    let updatedAt: String?
    let type: String?
    let typeID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case content = "content"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case type = "type"
        case typeID = "type_id"
    }
}

// MARK: Convenience initializers and mutators

extension HistoryNoti {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HistoryNoti.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        status: Bool?? = nil,
        apiTokenStatus: Bool?? = nil,
        notifications: Notifications?? = nil
        ) -> HistoryNoti {
        return HistoryNoti(
            status: status ?? self.status,
            apiTokenStatus: apiTokenStatus ?? self.apiTokenStatus,
            notifications: notifications ?? self.notifications
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Notifications {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Notifications.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        currentPage: Int?? = nil,
        data: [Datum]?? = nil,
        firstPageURL: String?? = nil,
        from: Int?? = nil,
        lastPage: Int?? = nil,
        lastPageURL: String?? = nil,
        nextPageURL: String?? = nil,
        path: String?? = nil,
        perPage: Int?? = nil,
        prevPageURL: String?? = nil,
        to: Int?? = nil,
        total: Int?? = nil
        ) -> Notifications {
        return Notifications(
            currentPage: currentPage ?? self.currentPage,
            data: data ?? self.data,
            firstPageURL: firstPageURL ?? self.firstPageURL,
            from: from ?? self.from,
            lastPage: lastPage ?? self.lastPage,
            lastPageURL: lastPageURL ?? self.lastPageURL,
            nextPageURL: nextPageURL ?? self.nextPageURL,
            path: path ?? self.path,
            perPage: perPage ?? self.perPage,
            prevPageURL: prevPageURL ?? self.prevPageURL,
            to: to ?? self.to,
            total: total ?? self.total
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Datum {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Datum.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: Int?? = nil,
        title: String?? = nil,
        content: String?? = nil,
        createdAt: String?? = nil,
        updatedAt: String?? = nil,
        type: String?? = nil,
        typeID: Int?? = nil
        ) -> Datum {
        return Datum(
            id: id ?? self.id,
            title: title ?? self.title,
            content: content ?? self.content,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            type: type ?? self.type,
            typeID: typeID ?? self.typeID
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
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

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}



// MARK: Encode/decode helpers


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
    
    class func getNotifications(page: Int = 1, complation : @escaping (_ error : Error? , _ status : Bool? , _ noty: [Datum]?, _ last_page: Int)->Void) {
        guard let api_T = Helper.getAPIToken() else { return }
        let urll = "\(notificationsUrl)api_token=\(api_T)&page=\(page)"
        //http://192.168.0.27/champile/public/api/notifications?api_token=3f946b1884bcfd7cdc594dba8ccf5df4019f189bd2e7e33026b9e61977330e7ee14a51eb&page=1
        //var messageArray = [String?]()
        guard let url = URL(string: urll) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do
            {
                ///print(data)
                let historyNoti = try JSONDecoder().decode(HistoryNoti.self, from: data)
                if historyNoti.status! {
                    //print(times.status)
                    complation(error, true, historyNoti.notifications?.data, (historyNoti.notifications?.lastPage)!)
                }
                else {
                    //print(times.status)
                    //messageArray.append(times.message?.date[0])
                    complation(error, false, nil, page)
                }
            }
            catch let jsonError {
                //messageArray.append("Something gone wrong, please check your internet connection")
                complation(error , false, nil, page)
                print("§§Error JSONSerialization ", jsonError)    }
            }.resume()
    }
}










