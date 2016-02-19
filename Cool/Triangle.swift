//
//  Triangle.swift
//  Cool
//
//  Created by Steeve Pommier on 01/02/16.
//  Copyright © 2016 Steeve is working. All rights reserved.
//

import UIKit

class Triangle: UIView {

    @IBInspectable var lineWidth: CGFloat = 1 { didSet { setNeedsDisplay() } }
    @IBInspectable var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() } }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        
        // First line
        path.moveToPoint(CGPoint(x: rect.width / 2, y: 0))
        path.addLineToPoint(CGPoint(x: rect.width, y: rect.height))
        //path.lineWidth = lineWidth * 0.8
        
        // Second line
        path.moveToPoint(CGPoint(x: rect.width, y: rect.height))
        path.addLineToPoint(CGPoint(x: 0, y: rect.height))
        //path.lineWidth = lineWidth
        
        // Third line
        path.moveToPoint(CGPoint(x: 0, y: rect.height))
        path.addLineToPoint(CGPoint(x: rect.width / 2, y: 0))
        //path.lineWidth = lineWidth * 0.8
        
        color.set()
        path.stroke()
    }

}
