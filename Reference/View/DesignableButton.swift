//
//  DesignableButton.swift
//  Reference
//
//  Created by Alexey Davletshin on 28.04.2021.
//

import UIKit

@IBDesignable class DesignableButton : UIButton {
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth / 10
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            super.traitCollectionDidChange(previousTraitCollection)
            layer.borderColor = borderColor.cgColor
        }
    }
}
