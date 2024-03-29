//
//  AppDelegate.swift
//  push-interactive-app
//
//  Created by Srushtika Neelakantam on 09/07/2019.
//  Copyright © 2019 Srushtika Neelakantam. All rights reserved.
//

import UIKit
import Ably
import UserNotifications

extension Notification.Name {
    static let ablyPushDidActivate = Notification.Name(rawValue: "ablyPushDidActivate")
    static let ablyPushDidDeactivate = Notification.Name(rawValue: "ablyPushDidDeactivate")
}

// This can be any valid URL, for example: "http://192.168.1.50:62777/auth", where the IP address is your Mac machine, taken from system preferences.
//let authURL = "https://<YOUR-AUTH-SERVER>/auth" 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ARTPushRegistererDelegate {
    
    var homeController: HomeController!
    var window: UIWindow?
    var realtime: ARTRealtime!
    var channel: ARTRealtimeChannel!
    var subscribed = false
    var myDeviceId = ""
    var myClientId = ""
    var myDeviceToken = ""
    var myPushChannel = "push:"+String.random()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = ContainerController()
        
        print("** hello there")
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, err) in
            DispatchQueue.main.async() {
                UIApplication.shared.registerForRemoteNotifications()
                print("** after registerForRemoteNotifications")
            }
        }
        
        self.realtime = self.getAblyRealtime()
        self.realtime.connection.on { (stateChange) in
            print("** Connection state change: \(String(describing: stateChange))")
        }
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        DispatchQueue.main.async() {
            print("** didRegisterForRemoteNotificationsWithDeviceToken")
            self.myDeviceToken = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
            ARTPush.didRegisterForRemoteNotifications(withDeviceToken: deviceToken, realtime: self.realtime)
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        DispatchQueue.main.async() {
            print("** didFailToRegisterForRemoteNotificationsWithError")
            ARTPush.didFailToRegisterForRemoteNotificationsWithError(error, realtime: self.realtime)
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("** received notification: \(userInfo)")
    }
    
    private func getAblyRealtime() -> ARTRealtime {
        let options = ARTClientOptions()
        options.authCallback = { params, callback in
            self.getTokenRequest() { json, error in
                do {
                    callback(try ARTTokenRequest.fromJson(json!), nil)
                } catch let error as NSError {
                    callback(nil, error)
                }
            }
        }

        // Explicitly set the delegate for push activation/ deactivation/ update events.
       options.pushRegistererDelegate = self
        options.logLevel = ARTLogLevel.verbose
        realtime = ARTRealtime(options: options)
        realtime.connection.on { state in
            switch state.current {
            case .connected:
                print("Successfully connected to Ably with clientId")
                self.myClientId = String(self.realtime.auth.clientId ?? "none")
                self.myDeviceId = String(self.realtime.device.id)
                print(self.myClientId)
                print(self.myDeviceToken)
                print(self.myDeviceId)
                print(self.myPushChannel)
            case .failed:
                print("Connection to Ably failed")
            default:
                break
            }
        }
        return realtime
    }
    
    func getTokenRequest(completion: @escaping (NSDictionary?, Error?) -> ())  {
        let requestURL = URL(string: authURL)!
        let urlRequest = URLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) -> Void in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization
                        .jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                    completion(json, nil)
                } catch {
                    print("There was an error while obtaining JSON")
                }
            }
        }
        task.resume()
    }
    
    func didActivateAblyPush(_ error: ARTErrorInfo?) {
        print("!!!inside activate deletage")
        NotificationCenter.default.post(name: .ablyPushDidActivate, object: nil, userInfo: ["Error": error]) //emit this event to any subscribers
        if (error != nil) {
            print("activation failed")
            return
        }
        print("activation successful")
        return

    }
    
    func didDeactivateAblyPush(_ error: ARTErrorInfo?) {
        print("!!!inside deactivate deletage")
        NotificationCenter.default.post(name: .ablyPushDidDeactivate, object: nil, userInfo: ["Error": error]) //emit this event to any subscribers
        if (error != nil) {
            print("deactivation failed")
            return
        }
        print("deactivation successful")
        return
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Tell the app that we have finished processing the user's action (eg: tap on notification banner) / response
        // Handle received remoteNotification: 'response.notification.request.content.userInfo'
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show the notification alert in foreground
        print("Got notification!")
        completionHandler([.alert, .sound])
    }
    
}

extension String {
    
    static func random(length: Int = 8) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
