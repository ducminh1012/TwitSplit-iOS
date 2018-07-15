//
//  UIColor+extensions.swift
//  TwitSplit-iOS
//
//  Created by MD on 7/15/18.
//  Copyright © 2018 MD. All rights reserved.
//

import UIKit

extension UIColor {
    class func hex(hex: String) -> UIColor {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        return UIColor(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
