//
//  DesignableButton.swift
//  SpeechRecognitionAPIDemo
//
//  Created by Shruti Sharma on 2/20/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import UIKit

@IBDesignable

class DesignableButton: UIButton {
    
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
