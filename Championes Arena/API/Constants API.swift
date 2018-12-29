import Foundation

let ServerUrl = "http://tech.techno-hat.com/champions_arena/public/"
//let ServerUrl = "http://192.168.0.27/champile/public/"
let MainUrl = ServerUrl + "api/"

// MARK: - URL FOR REGISTER
let registerURL = MainUrl + "users/register?"

// MARK: - URL FOR Sitting Player ID --->>> OneSignal
let setUserOneSignalToketUrl = MainUrl + "update_playerid?"

// MARK: - URL FOR LOGIN
let loginURL = MainUrl + "users/login?"

// MARK: - URL FOR UPDATE PROFILE
let updateProfileURL = MainUrl + "users/profile/update?"

// MARK: - URL FOR PROFILE
let profileURL = MainUrl + "users/profile?"

// MARK: - URL FOR NEWS
let newsURL = MainUrl + "news?"

// MARK: - URL FOR Playgrounds
let PlayURL = MainUrl + "playgrounds?"

// MARK: - URL FOR FACILITIES
let facURL = MainUrl + "facilities?"

/*
 GET DATA AND BOOKING
 */

// MARK: - URL FOR Get Times
let getTheTimes = MainUrl + "times?"

// MARK: - URL FOR Storing Bookings
let bookTimesurl = MainUrl + "store_booking?"

// MARK: - URL FOR Booking
let historyurl = MainUrl + "bookings_user?"

// MARK: - URL FOR Notifications
let notificationsUrl = MainUrl + "notifications?"

// MARK: - URL FOR Notifications Click
let notificationClickURL = MainUrl + "notifications/get_data?"



/*
 IMGES DOWNLOAD
 */

// MARK: - URL FOR Images
let mainIMGurl = ServerUrl + "images/"

let imgURLnews = mainIMGurl + "news/"
let imgURLplay = mainIMGurl + "playgrounds/"
let imgURLfac = mainIMGurl + "facilities/"



/*
 FILES DOWNLOAD
 */

// MARK: - URL FOR Files
let mainFileurl = ServerUrl + "files/facilities/"



/*
 Rate AND Send Message
 */

// MARK: - URL FOR Check Rate
let check_RateURL = MainUrl + "check_rate?"

// MARK: - URL FOR Rate
let rateUrl = MainUrl + "rate?"

// MARK: - URL FOR Send Message
let messageUrl = MainUrl + "message?"


















