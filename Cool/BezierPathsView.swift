//
//  BezierPathsView.swift
//  Dropit
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class BezierPathsView: UIView
{
    
    private var bezierPaths = [String:(path: UIBezierPath?, color: UIColor)]()
    
    func setPath(path: UIBezierPath?, named name: String, preferedColor: UIColor = UIColor.blackColor()) {
        bezierPaths[name] = (path: path, color: preferedColor)
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        for (_, item) in bezierPaths {
            if let path = item.path {
                item.color.set()
                path.stroke()
            }
        }
    }
}
