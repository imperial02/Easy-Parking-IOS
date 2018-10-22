//
//  Constants.swift
//  Easy - Parking
//
//  Created by Любчик on 9/23/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import CoreLocation

struct Constants {
    static let googleApiKey = "AIzaSyB0hFRsHyWdduLXZrkdIPMrL2SGFOHAe90"
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

struct NotificationConstants {
    static let notificationMessageTitle = "We find free parking space"
    static let notificationMessageSubTitle = "Some text"
    static let notificationMessageBody = "The close free place is:"
    static let notificationMessageIdentifier = "notificationIdentifier"
    static let openNotificationActionIdentifier = "OPEN"
    static let openNotificationActionTitle = "Open App"
    static let cancelNotificationActionIdentifier = "CANCEL"
    static let cancelNotificationActionTitle = "Close"
    static let categoryIdentifier = "Category"
}

struct RegionConstants {
    static let regionIdentifier = "Region"
    static let radius: CLLocationDistance = 200
}
