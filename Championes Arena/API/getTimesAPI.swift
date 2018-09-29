// To parse the JSON, add this file to your project and do:
//
//   let times = try Times(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.timesTask(with: url) { times, response, error in
//     if let times = times {
//       ...
//     }
//   }
//   task.resume()

import Foundation

struct Times: Codable {
    let status, apiTokenStatus: Bool
    let message: Message!
    let availableTime, unconfirmed: [String]!
    
    enum CodingKeys: String, CodingKey {
        case status
        case apiTokenStatus = "api_token_status"
        case message
        case availableTime = "available_time"
        case unconfirmed
    }
}

struct Message: Codable {
    let date: [String]!
}

// MARK: Convenience initializers and mutators

extension Times {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Times.self, from: data)
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
        status: Bool? = nil,
        apiTokenStatus: Bool? = nil,
        message: Message? = nil,
        availableTime: [String]? = nil,
        unconfirmed: [String]? = nil
        ) -> Times {
        return Times(
            status: status ?? self.status,
            apiTokenStatus: apiTokenStatus ?? self.apiTokenStatus,
            message: message ?? self.message,
            availableTime: availableTime ?? self.availableTime,
            unconfirmed: unconfirmed ?? self.unconfirmed
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Message {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Message.self, from: data)
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
        date: [String]? = nil
        ) -> Message {
        return Message(
            date: date ?? self.date
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
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

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func timesTask(with url: URL, completionHandler: @escaping (Times?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}



class GetTimesClass {

    class func getTimes(playground_id: Int, date: String, complation : @escaping (_ error : Error? , _ status : Bool? , _ messagesArray: [String]? , _ availbleTimes: [String]?, _ unconfirmedTimes: [String]?  )->Void){
        
        let urll = "\(getTheTimes)playground_id=\(playground_id)&date=\(date)"
        print(urll)
///        let urll = "http://tech.techno-hat.com/champions_arena/public/api/times?playground_id=\(playground_id)&date=\(date)"
        var messageArray = [String?]()
        guard let url = URL(string: urll) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do
            {
                let times = try JSONDecoder().decode(Times.self, from: data)
                if times.status {
                print(times.status)
                complation(error , times.status , nil, times.availableTime , times.unconfirmed)
                }
                else {
                    print(times.status)
                    messageArray.append(times.message?.date[0])
                    complation(error , false , messageArray as? [String] , nil, nil)
                }
            }
            catch let jsonError {
                messageArray.append("Something gone wrong, please check your internet connection")
                complation(error , false , messageArray as? [String] , nil, nil)
                print("§§Error JSONSerialization ", jsonError)    }
            }.resume()
        }
        
    }

