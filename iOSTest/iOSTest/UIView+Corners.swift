//
//  UIView+Corners.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-10-22.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = (newValue > 0)
        }
    }
}
