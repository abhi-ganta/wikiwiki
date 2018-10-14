//
//  wikiwiki+UIColor.swift
//  wikiwiki
//
//  Created by Brian Lin on 9/7/18.
//  Copyright © 2018 Brian Lin. All rights reserved.
//

import UIKit

extension UIColor {
    public enum wikiwiki {
        case red, green, blue, orange, purple
        
        public func color() -> UIColor {
            switch self {
            case .red:
                return UIColor(red:0.89, green:0.34, blue:0.18, alpha:1.0)
            case .orange:
                return UIColor(red:1.00, green:0.65, blue:0.00, alpha:1.0)
            case .green:
                return UIColor(red:0.36, green:0.99, blue:0.80, alpha:1.0)
            case .blue:
                return UIColor(red:0.29, green:0.70, blue:0.99, alpha:1.0)
            case .purple:
                return UIColor(red:0.70, green:0.53, blue:0.92, alpha:1.0)
            }
        }
    }
    
    public class func wikiwiki_randomColor() -> UIColor {
        let random = Int.random(in: 0 ..< 100)
        
        switch random % 4 {
        case 0:
            return UIColor.wikiwiki.red.color()
        case 1:
            return UIColor.wikiwiki.blue.color()
        case 2:
            return UIColor.wikiwiki.purple.color()
        case 4:
            return UIColor.wikiwiki.orange.color()
        default:
            return UIColor.wikiwiki.orange.color()
        }
    }
}
