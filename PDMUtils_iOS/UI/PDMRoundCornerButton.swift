//
//  PDMRoundCornerButton.swift
//  PDMUtils_iOS
//
//  Created by Pedro L. Diaz Montilla on 13/4/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import UIKit

@IBDesignable class PDMRoundCornerButton: UIButton {

    @IBInspectable var pdmBorderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = pdmBorderColor.cgColor
        }
    }
    
    @IBInspectable var pdmBorderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = pdmBorderWidth
        }
    }
    @IBInspectable var pdmCornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = pdmCornerRadius
        }
    }

}
