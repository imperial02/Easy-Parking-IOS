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
        return true
    }

}

