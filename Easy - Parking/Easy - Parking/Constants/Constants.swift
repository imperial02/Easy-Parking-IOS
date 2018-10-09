//
//  Constants.swift
//  Easy - Parking
//
//  Created by Любчик on 9/23/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

struct Constants {
    static let googleApiKey = "AIzaSyDXc-Q2sl5nh3_PnNhedALC8u40uKtuGqI"
    static let alertTitle = "Ooops.."
    static let alertMessage = "Smth goes wrong check your Internet"
    static let alertButtonTitle = "Ok"
    static let cancelButtonTitle = "Cancel"
    static let restrictedAlertTitle = "Check your lcoation services"
    static let restrictedAlertMessage = "Please check your preferences for using the app below"
    static let restrictedAlertButtonName = "Ok"
    static let storyboardName = "Main"
    static let noLocationControllerStoryboardIdentifier = "NoLocationViewController"
}

struct EasyParkingURLConstants {
    static let easyParkingSchema = "https"
    static let easyParkingApiHost = "easyparking.pythonanywhere.com"
    static let easyParkingApiPath = "/get/locations"
}
