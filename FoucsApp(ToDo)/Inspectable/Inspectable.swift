//
//  Inspectable.swift
//  FoucsApp(ToDo)
//
//  Created by Ebraheem Alnaqer on 11/09/2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
