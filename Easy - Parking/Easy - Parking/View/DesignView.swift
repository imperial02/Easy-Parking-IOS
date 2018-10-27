//
//  File.swift
//  Easy - Parking
//
//  Created by Любчик on 10/20/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable final class DesignView: UIView {
    
    @IBInspectable var cornerRadius:CGFloat = 0
    
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    
    @IBInspectable var shadowOffSetWidth :Int = 0
    
    @IBInspectable var shadowOffSetHeight :Int = 1
    
    @IBInspectable var shadowOpacity :Float = 0.2
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth ,height: shadowOffSetHeight)
        let shadowPath = UIBezierPath (roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
    }
    
}
