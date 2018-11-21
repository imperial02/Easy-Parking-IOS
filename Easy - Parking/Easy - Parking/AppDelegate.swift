//
//  AppDelegate.swift
//  Easy - Parking
//
//  Created by Любчик on 9/16/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(Constants.googleApiKey)
        GMSPlacesClient.provideAPIKey(Constants.googleApiKey)
        ReachabilityManager.shared.startMonitoring()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        ReachabilityManager.shared.startMonitoring()
        if((self.window?.subviews.count)! > 1) {
            self.window?.subviews.last?.removeFromSuperview()
        }

    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        ReachabilityManager.shared.stopMonitoring()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        let launchStoryboard : UIStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let launchViewController : UIViewController = launchStoryboard.instantiateViewController(withIdentifier: "LS") as UIViewController
        let launchView : UIView = launchViewController.view!
        self.window?.addSubview(launchView)
    }
    
}

