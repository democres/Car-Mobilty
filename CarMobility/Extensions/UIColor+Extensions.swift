//
//  UIColor+Extensions.swift
//  CarMobility
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Colors
extension UIColor {
    
    class func semaphoreGreen() -> UIColor {
        return UIColor(red:34/255.0, green: 134/255.0, blue: 34/255.0, alpha: 1.0)
    }
    
    class func semaphoreRed() -> UIColor {
        return UIColor(red: 0.8823, green: 0.1019, blue: 0.1725, alpha: 1.0)
    }
    
    class func purpleBrown(_ alpha: CGFloat = 0.6) -> UIColor {
        return UIColor(red: 35.0 / 255.0, green: 31.0 / 255.0, blue: 32.0 / 255.0, alpha: alpha)
    }
    
    class func charcoal() -> UIColor {
        return UIColor(red: 67 / 255.0, green: 72 / 255.0, blue: 77 / 255.0, alpha: 1.0)
    }
}

// MARK: - Fonts
extension UIFont {
    
    class func coordinatesFont(size: CGFloat = 8) -> UIFont {
        return UIFont(name: "Avenir", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
