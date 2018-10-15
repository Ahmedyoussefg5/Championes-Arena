//import UIKit
//import OneSignal
//
//class OneSignalMethods{//: OSPermissionObserver, OSSubscriptionObserver, OSEmailSubscriptionObserver {
//
//    //    @IBOutlet weak var textView: UITextView!
//    //    @IBOutlet weak var allowNotificationsSwitch: UISwitch!
//    //    @IBOutlet weak var setSubscriptionLabel: UILabel!
//    //    @IBOutlet weak var registerForPushNotificationsButton: UIButton!
//    //
//    //    @IBOutlet weak var emailTextField: UITextField!
//    //    @IBOutlet weak var setEmailButton: UIButton!
//    //    @IBOutlet weak var logoutEmailButton: UIButton!
//    //    @IBOutlet weak var setEmailActivityIndicatorView: UIActivityIndicatorView!
//    //    @IBOutlet weak var logoutEmailActivityIndicatorView: UIActivityIndicatorView!
//    //    @IBOutlet weak var logoutEmailTrailingConstraint: NSLayoutConstraint!
//
//
//
//    init() {
//
//        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
//        let isSubscribed = status.subscriptionStatus.subscribed
//
//        //        if isSubscribed == true {
//        //            //allowNotificationsSwitch.isOn = true
//        //            //allowNotificationsSwitch.isUserInteractionEnabled = true
//        //            //registerForPushNotificationsButton.backgroundColor = UIColor.green
//        //            //registerForPushNotificationsButton.isUserInteractionEnabled = false
//        //        }
//        OneSignal.add(self as! OSPermissionObserver)
//        OneSignal.add(self as! OSSubscriptionObserver)
//        OneSignal.add(self as! OSEmailSubscriptionObserver)
//
//        //self.emailTextField.delegate = self;
//    }
//
//    func displaySettingsNotification() {
//        let message = NSLocalizedString("Please turn on notifications by going to Settings > Notifications > Allow Notifications", comment: "Alert message when the user has denied access to the notifications")
//        let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: "Alert button to open Settings"), style: .`default`, handler: { action in
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
//            } else {
//                // Fallback on earlier versions
//            }
//        });
//        self.displayAlert(title: message, message: "OneSignal Example", actions: [UIAlertAction.okAction(), settingsAction]);
//    }
//
//    func displayError(withMessage message : String) {
//        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil);
//        self.displayAlert(title: "An Error Occurred", message: message, actions: [action])
//    }
//
//    func displayAlert(title : String, message: String, actions: [UIAlertAction]) {
//        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert);
//        actions.forEach { controller.addAction($0) };
//        //present(controller, animated: true, completion: nil);
//    }
//
//    func onOSPermissionChanged(_ stateChanges: OSPermissionStateChanges!) {
//        if stateChanges.from.status == OSNotificationPermission.notDetermined {
//            if stateChanges.to.status == OSNotificationPermission.authorized {
//                //registerForPushNotificationsButton.backgroundColor = UIColor.green
//                //registerForPushNotificationsButton.isUserInteractionEnabled = false
//                //allowNotificationsSwitch.isUserInteractionEnabled = true
//            } else if stateChanges.to.status == OSNotificationPermission.denied {
//                displaySettingsNotification()
//            }
//        } else if stateChanges.to.status == OSNotificationPermission.denied { // DENIED = NOT SUBSCRIBED
//            //registerForPushNotificationsButton.isUserInteractionEnabled = true
//            //allowNotificationsSwitch.isUserInteractionEnabled = false
//        }
//    }
//
//    func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges!) {
//        if stateChanges.from.subscribed && !stateChanges.to.subscribed { // NOT SUBSCRIBED != DENIED
//            //allowNotificationsSwitch.isOn = false
//            //setSubscriptionLabel.text = "Set Subscription OFF"
//            //registerForPushNotificationsButton.backgroundColor = UIColor.red
//        } else if !stateChanges.from.subscribed && stateChanges.to.subscribed {
//            //allowNotificationsSwitch.isOn = true
//            //allowNotificationsSwitch.isUserInteractionEnabled = true
//            //setSubscriptionLabel.text = "Set Subscription ON"
//            //registerForPushNotificationsButton.backgroundColor = UIColor.green
//            //registerForPushNotificationsButton.isUserInteractionEnabled = false
//        }
//    }
//
//    func onOSEmailSubscriptionChanged(_ stateChanges: OSEmailSubscriptionStateChanges!) {
//        let data = String(data: try! JSONSerialization.data(withJSONObject: stateChanges.toDictionary(), options: .prettyPrinted), encoding: .utf8);
//        print( data! )
//    }
//
//    func onRegisterForPushNotificationsButton() {
//        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
//        let hasPrompted = status.permissionStatus.hasPrompted
//        if hasPrompted == false {
//            // Call when you want to prompt the user to accept push notifications.
//            // Only call once and only if you set kOSSettingsKeyAutoPrompt in AppDelegate to false.
//            OneSignal.promptForPushNotifications(userResponse: { accepted in
//                if accepted == true {
//                    print("User accepted notifications: \(accepted)")
//                } else {
//                    print("User accepted notifications: \(accepted)")
//                }
//            })
//        } else {
//            displaySettingsNotification()
//        }
//    }
//
//    @IBAction func onSendTagsButton(_ sender: UIButton) {
//
//        let tags: [AnyHashable : Any] = [
//            "some_key" : "some_value",
//            "users_name" : "Jon",
//            "finished_level" : "30",
//            "has_followers" : "false",
//            "added_review" : "false"
//        ]
//
//        OneSignal.sendTags(tags, onSuccess: { result in
//            print("Tags sent - \(result!)")
//        }) { error in
//            print("Error sending tags: \(error?.localizedDescription ?? "None")")
//        }
//    }
//
//    @IBAction func onGetTagsButton(_ sender: UIButton) {
//        OneSignal.getTags({ tags in
//            print("tags - \(tags!)")
//
//            guard let tags = tags else {
//                self.displayAlert(title: NSLocalizedString("No Tags Available", comment: "Alert message when there were no tags available for this user"), message: NSLocalizedString("There were no tags present for this device", comment: "No tags available for this user"), actions: [UIAlertAction.okAction()]);
//                return;
//            };
//
//            if JSONSerialization.isValidJSONObject(tags), let tagsData = try? JSONSerialization.data(withJSONObject: tags, options: .prettyPrinted), let tagsString = String(data: tagsData, encoding: .utf8) {
//                self.displayAlert(title: NSLocalizedString("Tags JSON", comment: "Title for displaying tags JSON"), message: tagsString, actions: [UIAlertAction.okAction()]);
//            } else {
//                self.displayAlert(title: NSLocalizedString("Unable to Parse Tags", comment: "Alerts the user that tags are present but unable to be parsed"), message: NSLocalizedString("Tags exist but are unable to be parsed or displayed as a string", comment: "Informs the user that the app is unable to parse tags"), actions: [UIAlertAction.okAction()]);
//            }
//
//        }, onFailure: { error in
//            print("Error getting tags - \(error?.localizedDescription ?? "None")")
//            // errorWithDomain - OneSignalError
//            // code - HTTP error code from the OneSignal server
//            // userInfo - JSON OneSignal responded with
//        })
//    }
//
//    func DeleteOrUpdateTags() {
//        //OneSignal.deleteTag("some_key")
//        OneSignal.deleteTags(["some_key", "users_name", "has_followers", "added_review"])
//        // To update tags simply add new ones
//        OneSignal.sendTags(["finished_level" : "60"])
//    }
//
//    class func getUserIdOneSignal(){
//        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
//        let userID = status.subscriptionStatus.userId
//        print("userID = \(userID ?? "None")")
//
//        userToken_OneSignal = userID ?? "None"
//    }
//
//    // User IDs // Get Player ID
//    class func GetIDsButton() {
//        //getPermissionSubscriptionState
//        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
//        let hasPrompted = status.permissionStatus.hasPrompted
//        print("hasPrompted = \(hasPrompted)")
//        let userStatus = status.permissionStatus.status
//        print("userStatus = \(userStatus)")
//        let isSubscribed = status.subscriptionStatus.subscribed
//        print("isSubscribed = \(isSubscribed)")
//        let userSubscriptionSetting = status.subscriptionStatus.userSubscriptionSetting
//        print("userSubscriptionSetting = \(userSubscriptionSetting)")
//        let userID = status.subscriptionStatus.userId
//        print("userID = \(userID ?? "None")")
//        let pushToken = status.subscriptionStatus.pushToken
//        print("pushToken = \(pushToken ?? "None")")
//    }
//
//    func onSyncEmailButton() {
//        // Optional method that sends us the user's email as an anonymized hash so that we can better target and personalize notifications sent to that user across their devices.
//        let testEmail = "test@test.test"
//        OneSignal.setEmail(testEmail)
//        OneSignal.syncHashedEmail(testEmail)
//        print("sync hashedEmail successful")
//    }
//
//    func PromptLocationButton(_ sender: UIButton) {
//        // promptLocation method
//        // Prompts the user for location permissions to allow geotagging from the OneSignal dashboard. This lets you send notifications based on the device's location.
//        /* add to info.plist:
//         <key>NSLocationAlwaysUsageDescription</key>
//         <string>Your message goes here</string>
//         <key>NSLocationWhenInUseUsageDescription</key>
//         <string>Your message goes here</string>
//         */
//        // must add core location framework for this to work. Root Project > Build Phases > Link Binary With Libraries
//        OneSignal.promptLocation()
//        print("OneSignal version: " + OneSignal.sdk_semantic_version());
//    }
//
//    // Sending Notifications
//    @IBAction func SendNotification() {
//        // See the Create notification REST API POST call for a list of all possible options: https://documentation.onesignal.com/reference#create-notification
//        // NOTE: You can only use include_player_ids as a targeting parameter from your app. Other target options such as tags and included_segments require your OneSignal App REST API key which can only be used from your server.
//        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
//        let pushToken = status.subscriptionStatus.pushToken
//        let userId = status.subscriptionStatus.userId
//
//        if pushToken != nil {
//            let message = "This is a notification's message or body"
//            let notificationContent = [
//                "include_player_ids": [userId],
//                "contents": ["en": message], // Required unless "content_available": true or "template_id" is set
//                "headings": ["en": "Notification Title"],
//                "subtitle": ["en": "An English Subtitle"],
//                // If want to open a url with in-app browser
//                //"url": "https://google.com",
//                // If you want to deep link and pass a URL to your webview, use "data" parameter and use the key in the AppDelegate's notificationOpenedBlock
//                "data": ["OpenURL": "https://imgur.com"],
//                "ios_attachments": ["id" : "https://cdn.pixabay.com/photo/2017/01/16/15/17/hot-air-balloons-1984308_1280.jpg"],
//                "ios_badgeType": "Increase",
//                "ios_badgeCount": 1
//                ] as [String : Any]
//
//            OneSignal.postNotification(notificationContent)
//        }
//    }
//
//    func SendNotification2() {
//        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
//        let pushToken = status.subscriptionStatus.pushToken
//        let userId = status.subscriptionStatus.userId
//
//        if pushToken != nil {
//            let notifiation2Content: [AnyHashable : Any] = [
//                // Update the following id to your OneSignal plyaer / user id.
//                "include_player_ids": [userId],
//                // Tag substitution: https://documentation.onesignal.com/docs/tag-variable-substitution
//                "headings": ["en": "Congrats {{users_name}}!!"],
//                "contents": ["en": "You finished level {{ finished_level | default: '1' }}! Let's see if you can do more."],
//                // Action Buttons: https://documentation.onesignal.com/reference#section-action-buttons
//                "buttons": [["id": "id1", "text": "GREEN"], ["id": "id2", "text": "RED"]]
//            ]
//            OneSignal.postNotification(notifiation2Content, onSuccess: { result in
//                print("result = \(result!)")
//            }, onFailure: {error in
//                print("error = \(error!)")
//            })
//        }
//    }
//
//    func AllowNotificationsOrDisallow() {
//        // turn off notifications
//        // IMPORTANT: user must have already accepted notifications for this to be called
//        let isAllowed = true
//        if !isAllowed {
//            OneSignal.setSubscription(false)
//        } else {
//            OneSignal.setSubscription(true)
//        }
//    }
//
//    func setEmail() {
//        let eMail = "a@ads.com"
//        OneSignal.setEmail(eMail ?? "", withSuccess: {
//
//            print("Loged Out Successfully")
//
//        }) { (error) in
//            print(error!)
//            self.displayError(withMessage: "Encountered error while attempting to set email: " + (error?.localizedDescription ?? "null"));
//        };
//    }
//
//    class func logoutEmail() {
//        //self.changeLogoutAnimationState(true);
//
//        OneSignal.logoutEmail(success: {
//            print("success")
//        }) { (error) in
//            print(error!)
//
//            //self.displayError(withMessage: "Encountered error while attempting to log out of email: " + (error?.localizedDescription ?? "null"));
//        };
//
//        OneSignal.setSubscription(false)
//    }
//
////    class func notificationClicked () {
////        let appID = "d24c5012-f415-425f-935c-0a647108db48"
////
////        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
////            // This block gets called when the user reacts to a notification received
////            let payload: OSNotificationPayload? = result?.notification.payload
////
////            print("Message: \(payload!.body)")
////            print("badge number:", payload?.badge ?? "nil")
////            print("notification sound:", payload?.sound ?? "nil")
////
////            if let additionalData = result!.notification.payload!.additionalData {
////                print("additionalData = \(additionalData)")
////
////                // DEEP LINK and open url in RedViewController
////                // Send notification with Additional Data > example key: "OpenURL" example value: "https://google.com"
////                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
////                let instantiateRedViewController : WebView = mainStoryboard.instantiateViewController(withIdentifier: "WebViewID") as! WebView
////                instantiateRedViewController.receivedURL = additionalData["OpenURL"] as! String!
////                self.window = UIWindow(frame: UIScreen.main.bounds)
////                self.window?.rootViewController = instantiateRedViewController
////                self.window?.makeKeyAndVisible()
////
////
////                if let actionSelected = payload?.actionButtons {
////                    print("actionSelected = \(actionSelected)")
////                }
////
////                // DEEP LINK from action buttons
////                if let actionID = result?.action.actionID {
////
////                    // For presenting a ViewController from push notification action button
////                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
////                    let actionWebView : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "WebViewID") as UIViewController
////                    let actionSecond: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "SecondID") as UIViewController
////                   // self.window = UIWindow(frame: UIScreen.main.bounds)
////
////                    print("actionID = \(actionID)")
////
////                    if actionID == "id2" {
////                        print("id2")
////                      //  self.window?.rootViewController = actionWebView
////                      //  self.window?.makeKeyAndVisible()
////
////
////                    } else if actionID == "id1" {
////                        print("id1")
////                      //  self.window?.rootViewController = actionSecond
////                      //  self.window?.makeKeyAndVisible()
////
////                    }
////                }
////            }
////        }
////
////        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: true, ]
////
////        OneSignal.initWithLaunchOptions(launchOptions, appId: appID, handleNotificationAction: notificationOpenedBlock, settings: onesignalInitSettings)
////
////
////        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification
////
////        // Recommend moving the below line to prompt for push after informing the user about
////        //   how your app will use them.
////        OneSignal.promptForPushNotifications(userResponse: { accepted in
////            print("User accepted notifications: \(accepted)")
////        })
////
////
////        // Sync hashed email if you have a login system or collect it.
////        //   Will be used to reach the user at the most optimal time of day.
////        // OneSignal.syncHashedEmail(userEmail
////    }
//
//}
//
//extension UIAlertAction {
//    static func okAction() -> UIAlertAction {
//        return UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil);
//    }
//}
