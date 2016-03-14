//
//  Circle.swift
//  Cool
//
//  Created by Steeve Pommier on 05/03/16.
//  Copyright © 2016 Steeve is working. All rights reserved.
//

import UIKit

@IBDesignable
class Circle: UIView {
    
    @IBInspectable var lineWidth: CGFloat = 1 { didSet { setNeedsDisplay() } }
    @IBInspectable var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() } }
    
    var radius: CGFloat {
        return CGFloat((CGFloat(bounds.size.width) - CGFloat(lineWidth)) / 2)
    }
    
    var centerFromView: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    override func drawRect(rect: CGRect) {
        let circlePath = UIBezierPath(arcCenter: centerFromView, radius: radius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        circlePath.lineWidth = lineWidth
        color.set()
        circlePath.stroke()
    }
}

