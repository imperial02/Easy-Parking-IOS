//
//  Utils.swift
//  Easy - Parking
//
//  Created by Любчик on 11/21/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static var noInternetConnectionViewController: NoInternetViewController?
    
    func showNoInternetView(isActive active: Bool) {
        if UIViewController.noInternetConnectionViewController == nil  {
            UIViewController.noInternetConnectionViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoInternetViewController") as! NoInternetViewController)
        }
        if active {
            removeViewControllerAsChildViewController(childView: UIViewController.noInternetConnectionViewController!)
        } else  {
            addViewControllerAsChildViewController(childView: UIViewController.noInternetConnectionViewController!)
        }
    }
    
    func addViewControllerAsChildViewController(childView: UIViewController) {
        addChildViewController(childView)
        self.view.addSubview(childView.view)
        
        childView.view.frame = UIApplication.shared.keyWindow!.frame
        UIApplication.shared.keyWindow!.addSubview(childView.view)
        childView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childView.didMove(toParentViewController: self)
    }
    
    func removeViewControllerAsChildViewController(childView: UIViewController) {
        childView.willMove(toParentViewController: nil)
        childView.view.removeFromSuperview()
        childView.removeFromParentViewController()
    }

}
