import Foundation

struct History2: Codable {
    let status, statusToken: Bool?
    let data: DataClass?
    
    enum CodingKeys: String, CodingKey {
        case status
        case statusToken = "status_token"
        case data
    }
}

struct DataClass: Codable {
    let id: Int?
    let title, content, image: String?
    let clubID: Int?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, content, image
        case clubID = "club_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

extension ApiMethods {
    
    class func getNotificationsContentForOneNews(id: Int ,complation : @escaping (_ error : Error? , _ status : Bool? , _ noty: [DataClass]?)->Void) {
        guard let api_T = Helper.getAPIToken() else { return }
        let urll = "\(notificationClickURL)api_token=\(api_T)&type=news&type_id=\(id)"
        //http://localhost/champile/public/api/notifications/get_data?api_token=5d4856c929ffb44e&type=news&type_id=1
        //var messageArray = [String?]()
        guard let url = URL(string: urll) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do
            {
                let newsOnlyOne = try JSONDecoder().decode(History2.self, from: data)
                if newsOnlyOne.status! {
                    //print(times.status)
                    complation(error, true, [newsOnlyOne.data!])
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
