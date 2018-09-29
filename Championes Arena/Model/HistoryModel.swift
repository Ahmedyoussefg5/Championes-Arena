//
//  File.swift
//  Champione Arena
//
//  Created by Youssef on 9/19/18.
//  Copyright © 2018 Youssef. All rights reserved.
//


// To parse the JSON, add this file to your project and do:
//
//   let history = try History(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.historyTask(with: url) { history, response, error in
//     if let history = history {
//       ...
//     }
//   }
//   task.resume()

import Foundation

struct History: Codable {
    let status, apiTokenStatus: Bool
    let bookings: [Booking]!
    
    enum CodingKeys: String, CodingKey {
        case status
        case apiTokenStatus = "api_token_status"
        case bookings
    }
}

struct Booking: Codable {
    let id, userID: Int
    let timeFrom, timeTo, date: String
    let playgroundID: Int
    let status: String
    let createdBy: CreatedBy
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case timeFrom = "time_from"
        case timeTo = "time_to"
        case date
        case playgroundID = "playground_id"
        case status
        case createdBy = "created_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum CreatedBy: String, Codable {
    case user = "user"
}

enum Status: String, Codable {
    case wait = "wait"
}

// MARK: Convenience initializers and mutators

extension History {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(History.self, from: data)
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
        bookings: [Booking]? = nil
        ) -> History {
        return History(
            status: status ?? self.status,
            apiTokenStatus: apiTokenStatus ?? self.apiTokenStatus,
            bookings: bookings ?? self.bookings
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Booking {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Booking.self, from: data)
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
        id: Int? = nil,
        userID: Int? = nil,
        timeFrom: String? = nil,
        timeTo: String? = nil,
        date: String? = nil,
        playgroundID: Int? = nil,
        status: Status? = nil,
        createdBy: CreatedBy? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
        ) -> Booking {
        return Booking(
            id: id ?? self.id,
            userID: userID ?? self.userID,
            timeFrom: timeFrom ?? self.timeFrom,
            timeTo: timeTo ?? self.timeTo,
            date: date ?? self.date,
            playgroundID: playgroundID ?? self.playgroundID,
            status: status.map { $0.rawValue } ?? self.status,
            createdBy: createdBy ?? self.createdBy,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}

//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}

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
    
    func historyTask(with url: URL, completionHandler: @escaping (History?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

