//
//  Box.swift
//  Cool
//
//  Created by Steeve Pommier on 11/12/15.
//  Copyright © 2015 Steeve is working. All rights reserved.
//

import UIKit

@IBDesignable
class Box: UIView {

    var x: Int?
    var y: Int?
    
    @IBInspectable var lineWidth: CGFloat = 0 { didSet { setNeedsDisplay() } }
    @IBInspectable var color: UIColor = UIColor.blueColor() {
        didSet {
            backgroundColor = color
            //setNeedsDisplay()
        }
    }
    
//    override func drawRect(rect: CGRect) {
//        
//    }

}