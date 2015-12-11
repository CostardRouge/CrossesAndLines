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
    
    @IBInspectable var lineWidth: CGFloat = 1 { didSet { setNeedsDisplay() } }
    @IBInspectable var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() } }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        
        // First line
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: rect.width, y: rect.height))
        color.set()
        path.stroke()
        
        // Second line
        path.moveToPoint(CGPoint(x: rect.width, y: 0))
        path.addLineToPoint(CGPoint(x: 0, y: rect.height))
        
        color.set()
        path.stroke()
    }
    
}
