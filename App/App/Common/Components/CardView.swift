//
//  CardView.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 25/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//
import UIKit

@IBDesignable class CardView: UIView {
    var cornnerRadius : CGFloat = 5
    var shadowOfSetWidth : CGFloat = 0
    var shadowOfSetHeight : CGFloat = 3

    var shadowColour : UIColor = .black
    var shadowOpacityValue : Float = 0.2

    override func layoutSubviews() {
        layer.cornerRadius = cornnerRadius
        layer.shadowColor = shadowColour.cgColor
        layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornnerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacityValue
    }
}
