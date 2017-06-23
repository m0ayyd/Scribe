//
//  CircleButton.swift
//  Scribe
//
//  Created by the Luckiest on 6/23/17.
//  Copyright © 2017 the Luckiest. All rights reserved.
//

import UIKit



@IBDesignable class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
}
