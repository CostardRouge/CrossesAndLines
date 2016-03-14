//
//  Cross.swift
//  Cool
//
//  Created by Steeve is working on 03/12/15.
//  Copyright © 2015 Steeve is working. All rights reserved.
//

import UIKit

@IBDesignable
class Cross: UIView {
    
    var haveToBeVerticallyDrawn:Bool = false
    
    @IBInspectable var lineWidth: CGFloat = 1 { didSet { setNeedsDisplay() } }
    @IBInspectable var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() } }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        
        if haveToBeVerticallyDrawn {
            path.moveToPoint(CGPoint(x: 0, y: rect.height / 2))
            path.addLineToPoint(CGPoint(x: rect.width, y: rect.height / 2))
            path.moveToPoint(CGPoint(x: rect.width / 2, y: 0))
            path.addLineToPoint(CGPoint(x: rect.width / 2, y: rect.height))
        }
        else {
            path.moveToPoint(CGPoint(x: 0, y: 0))
            path.addLineToPoint(CGPoint(x: rect.width, y: rect.height))
            path.moveToPoint(CGPoint(x: rect.width, y: 0))
            path.addLineToPoint(CGPoint(x: 0, y: rect.height))
        }
        
        color.set()
        path.stroke()
    }
}
