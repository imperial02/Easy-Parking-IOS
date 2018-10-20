//
//  AlertHelper.swift
//  Easy - Parking
//
//  Created by Любчик on 9/23/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import UIKit

final class AlertHelper {
    
    static let errorTitle = Constants.alertTitle
    static let okActionButtonTitle = Constants.alertButtonTitle
    static let cancelAction = UIAlertAction(title: Constants.cancelButtonTitle, style: .cancel, handler: nil)
    static func showAlert(on owner: UIViewController, title: String? = nil, message: String, buttonTitle: String, buttonAction: @escaping () -> Void, showCancelButton: Bool = true) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        if showCancelButton {
            alertController.addAction(AlertHelper.cancelAction)
        }
        let openAction = UIAlertAction(title: buttonTitle, style: .default) { action in buttonAction() }
        alertController.addAction(openAction)
        alertController.view.tintColor = .darkGray
        owner.present(alertController, animated: true, completion: nil)
    }
    
}
