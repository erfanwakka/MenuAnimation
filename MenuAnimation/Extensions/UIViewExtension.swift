//
//  UIViewExtension.swift
//  MenuAnimation
//
//  Created by erfan on 12/12/1398 AP.
//  Copyright © 1398 Erfan. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
