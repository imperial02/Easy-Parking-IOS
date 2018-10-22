//
//  NotificationManager.swift
//  Easy - Parking
//
//  Created by Любчик on 10/15/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import Foundation
import UserNotifications

protocol NotificationManagerDelegate: class {
    func didReceiveLocalNotification()
    func didShowController()
}

enum ActionIdentifier: String {
    case OPEN
    case CANCEL
}

class NotificationManager: NSObject {
    
    // MARK: - Variable
    private let notificationCenter = UNUserNotificationCenter.current()
    weak var delegate: NotificationManagerDelegate?
    
    override init() {
        super.init()
        notificationCenter.delegate = self
        askNotificationPermisson()
    }
    
    func showNotification() {
        let content = UNMutableNotificationContent()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        content.title = NotificationConstants.notificationMessageTitle
        content.subtitle = NotificationConstants.notificationMessageSubTitle
        content.body = NotificationConstants.notificationMessageBody
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = NotificationConstants.categoryIdentifier
        let request = UNNotificationRequest(identifier: NotificationConstants.notificationMessageIdentifier, content: content, trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: { error in
            if error == nil {
                self.setCategory()
                print("Notification sent")
            } else {
                guard let notifError = error else { return }
                print(notifError.localizedDescription)
            }
        })
    }
    
    // MARK: Private
    private func askNotificationPermisson () {
        let options: UNAuthorizationOptions = [.alert, .sound];
        notificationCenter.requestAuthorization(options: options) { (granted, error) in
            if granted {
                print("good")
            } else {
                guard let permissionError = error else { return }
                print("Notifications permission denied because: \(permissionError.localizedDescription).")
            }
        }
    }
    
    private func setCategory() {
        let cancelAction = UNNotificationAction(identifier: NotificationConstants.cancelNotificationActionIdentifier,
                                                title: NotificationConstants.cancelNotificationActionTitle,
                                                options: [.destructive])
        let openAction = UNNotificationAction(identifier: NotificationConstants.openNotificationActionIdentifier,
                                              title: NotificationConstants.openNotificationActionTitle,
                                              options: [.foreground])
        let category = UNNotificationCategory(identifier: NotificationConstants.categoryIdentifier,
                                              actions: [openAction, cancelAction],
                                              intentIdentifiers: [],
                                              options: [])
        notificationCenter.setNotificationCategories([category])
    }
    
}

// MARK: - UNUserNotificationCenterDelegate
extension NotificationManager: UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case ActionIdentifier.OPEN.rawValue:
            self.delegate?.didShowController()
        case ActionIdentifier.CANCEL.rawValue:
            break
        default:
            break
        }
        completionHandler()
        delegate?.didReceiveLocalNotification()
    }
    
}
