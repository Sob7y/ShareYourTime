//
//  AppDelegate.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/24/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase
import UserNotifications
import CoreLocation
import FBSDKLoginKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        GMSServices.provideAPIKey(Constant.keys.GOOGLE_MAPS_API_KEY)
        GMSPlacesClient.provideAPIKey(Constant.keys.GOOGLE_MAPS_API_KEY)
        locateMe()
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification(notification:)),
                                               name: Notification.Name.MessagingRegistrationTokenRefreshed,
                                               object: nil)
        
        getAppLanguage()
        L102Localizer.configure()
        FirebaseApp.configure()
        
        return true
    }
    
    func locateMe() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func application(_ application:UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        print("url \(url)")
        let directedByFB = ApplicationDelegate.shared.application(application, open: url, options: options)
        return directedByFB
    }
    
    @objc func tokenRefreshNotification(notification: NSNotification) {
        // NOTE: It can be nil here
        var refreshedToken : String?
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
                return
            } else if let result = result {
                refreshedToken = result.token
            }
        }
        
        print("InstanceID token: \(String(describing: refreshedToken))")
        if(refreshedToken != nil) {
            UserDefaults.standard.set(refreshedToken, forKey: Constant.keys.DEVICE_TOKEN)
            NotificationCenter.default.post(name: Notification.Name(Constant.keys.DEVICE_TOKEN), object: refreshedToken)
        }
        connectToFcm()
    }
    
    func getAppLanguage() {
//        let pre = Locale.preferredLanguages[0]
        let langStr = Locale.current.languageCode
        Strings.sharedInstance.changeLangugage(lang: Langugage(rawValue: langStr!)!)
        Defaults.sharedInstance.applicationLanguage = Langugage(rawValue: langStr!)!
    }
    
    func connectToFcm() {
        // Won't connect since there is no token
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
                return
            } else if let result = result {
                UserDefaults.standard.set(result.token, forKey: Constant.keys.DEVICE_TOKEN)
                NotificationCenter.default.post(name: Notification.Name(Constant.keys.DEVICE_TOKEN), object: result.token)
                print("Remote instance ID token: \(result.token)")
            }
        }
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    // This method will be called when app received push notifications in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
         print("userinfo = \(userInfo)")
        
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        
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

extension AppDelegate: MessagingDelegate {
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
}

extension AppDelegate {
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            let url = userActivity.webpageURL!
            let urlStr = url.absoluteString
            print("url = \(urlStr)")
        }
        
        
        return true
    }
    
    func presentDetailViewController(_ eventId: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let detailVC = storyboard
                .instantiateViewController(withIdentifier: "EventDetailsViewController")
                as? EventDetailsViewController,
            let navigationVC = storyboard
                .instantiateViewController(withIdentifier: "NavigationController")
                as? UINavigationController
            else { return }
        
        let eventModel = EventModel(id: Int(eventId) ?? 0)
        detailVC.eventModel = eventModel
        navigationVC.modalPresentationStyle = .formSheet
        navigationVC.pushViewController(detailVC, animated: true)
    }
}


extension AppDelegate:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = (locations[0] as CLLocation)
        UserDefaults.standard.set(userLocation.coordinate.latitude, forKey: Constant.keys.key_latitude)
        UserDefaults.standard.set(userLocation.coordinate.longitude, forKey: Constant.keys.key_longitude)
        UserDefaults.standard.synchronize()
    }
}
