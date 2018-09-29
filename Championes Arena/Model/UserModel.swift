import Foundation
import SwiftyJSON

class UserModel {
    
    var api_token : String!
    var email : String!
    var id : Int!
    var image : String!
    var updated_at : String!
    var created_at : String!
    var phone : String!
    var player_id : String!
    var birthday : String!
    var username : String!
    
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
    
    init(List : [String : JSON]) {
        
        if let api_token = List["api_token"]?.string {
            self.api_token = api_token
        }
        
        if let user = List["user"]?.dictionary {
            if let email = user["email"]?.string {
                self.email = email}
            if let id = user["id"]?.int {
                self.id = id}
            if let image = user["image"]?.string {
                self.image = image}
            if let updated_at = user["updated_at"]?.string {
                self.updated_at = updated_at}
            if let created_at = user["created_at"]?.string {
                self.created_at = created_at}
            if let phone = user["phone"]?.string {
                self.phone = phone}
            if let player_id = user["player_id"]?.string {
                self.player_id = player_id}
            if let birthday = user["birthday"]?.string {
                self.birthday = birthday}
            if let username = user["username"]?.string {
                self.username = username}
            
        }
        
        Helper.saveUserData(key: "id", value: String(self.id))
        Helper.saveUserData(key: "username", value: self.username)
        Helper.saveUserData(key: "phone", value: self.phone)
        Helper.saveUserData(key: "email", value: self.email)
    }
}











