import Foundation


// One Signal
var userToken_OneSignal = ""


//http://tech.techno-hat.com/champions_arena/public/api/user/register?
let ServerUrl = "http://tech.techno-hat.com/champions_arena/public/"

let MainUrl = ServerUrl + "api/"
//////////////////////////////////////////////////////////////////

// MARK: - URL FOR REGISTER
//http://localhost/champile/public/api/users/register?email=ahmed@gmail.com&password=123456&username=Ahmed&phone=01041256369
let registerURL = MainUrl + "users/register?"

// MARK: - URL FOR LOGIN
//http://tech.techno-hat.com/champile/public/api/users/login?email=mohamed-ali@gmail.com&password=123456
let loginURL = MainUrl + "users/login?"
var loginURLfull = ""

// MARK: - URL FOR UPDATE PROFILE
//http://tech.techno-hat.com/champile/public/api/users/profile/update?api_token=e8ed26d833da2fb30649f1c7e2972081cb0ca209986d5049e92d762a05be87d91223679c&email=mohamed-ali@gmail.com&password=123456&username=Mohamed Ali&phone=01541256369&birthday=1990-02-10
let updateProfileURL = MainUrl + "users/profile/update?"

// MARK: - URL FOR PROFILE
//http://tech.techno-hat.com/champile/public/api/users/profile?api_token=e8ed26d833da2fb30649f1c7e2972081cb0ca209986d5049e92d762a05be87d91223679c
let profileURL = MainUrl + "users/profile?"

// MARK: - URL FOR NEWS
//http://localhost/champile/public/api/news
let newsURL = MainUrl + "news"

// MARK: - URL FOR Playgrounds
//http://localhost/champile/public/api/playgrounds
let PlayURL = MainUrl + "playgrounds"

// MARK: - URL FOR FACILITIES
//http://localhost/champile/public/api/facilities
let facURL = MainUrl + "facilities"

/*
 IMGES DOWNLOAD
 
Get available times and unconfirmed times http://tech.techno-hat.com/champions_arena/public/api/times?playground_id=2&date=2018-09-19
 
Store booking in DB http://localhost/champile/public/api/store_booking?api_token=fdf3e6d5a4e2bf0cfc9c5dbde7296f28c45c2b988a350025196b7aa5917035be31dad4df&date=2018-09-18&playground_id=2&times[]=21:00&times[]=22:00
*/
//http://tech.techno-hat.com/champions_arena/public/api/times?playground_id=2&date="2018-09-19"
let getTheTimes = MainUrl + "times?"
let bookTimesurl = MainUrl + "store_booking?"
//http://tech.techno-hat.com/champions_arena/public/api/bookings_user?api_token=6de57f43895b2fd6bcb1bbdf52842b8db486702c78287af434ec132d527e22a501951f45
let historyurl = MainUrl + "bookings_user?"
//http://192.168.0.27/champile/public/api/update_playerid?api_token=fdf3e6d5a4e2bf0cfc9c5dbde7296f28c45c2b988a350025196b7aa5917035be31dad4df&player_id=dugfuyedgfiuwegfuiswegdfiuwdui
let setUserOneSignalToketUrl = MainUrl + "update_playerid?"

/*
 IMGES DOWNLOAD
 */

//http://localhost/champile/public/images/users/8636f92cdaf01fa992ea149a4733085a2f8f4c72IMG_20180417_185346_684.jpg

let mainIMGurl = ServerUrl + "images/"

let imgURLnews = mainIMGurl + "news/"
let imgURLplay = mainIMGurl + "playgrounds/"
let imgURLfac = mainIMGurl + "facilities/"

var selectedCells11 = NSMutableIndexSet()
var selectedCells22 = NSMutableIndexSet()
var dayToday: Date = Date()

/*
 FILES DOWNLOAD
 */
//http://localhost/champile/public/files/facilities/8636f92cdaf01fa992ea149a4733085a2f8f4c72IMG_20180417_185346_684.jpg
let mainFileurl = ServerUrl + "files/facilities/"























