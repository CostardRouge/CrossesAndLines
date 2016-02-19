//
//  TracyViewController.swift
//  Cool
//
//  Created by Steeve Pommier on 10/02/16.
//  Copyright © 2016 Steeve is working. All rights reserved.
//

import UIKit

class TracyViewController: UIViewController {

    @IBOutlet weak var coolSceneView: BezierPathsView!
    var attachmentStrokeWidth: CGFloat = 1.0
    
    var fingers = [Int:CGPoint]()
    var oldLinePathnames = [Int:[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        coolSceneView?.multipleTouchEnabled = true
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        for touche in touches {
            
            let point = touche.locationInView(coolSceneView)
            fingers.updateValue(point, forKey: touche.hashValue)
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        for touche in touches {
            
            // clean lines
            // trace line from start point to actual point
            
            if let index = fingers.indexForKey(touche.hashValue) {
                
                let firstFinger = fingers[index]
                let firstPoint = firstFinger.1
                let fingerHashValue = firstFinger.0
                
                let toucheMovedPoint = touche.locationInView(coolSceneView)
                
                if let linePathnames = traceLinesForThisMove(fingerHashValue, startPoint: firstPoint, endPoint: toucheMovedPoint) {
                    oldLinePathnames.updateValue(linePathnames, forKey: touche.hashValue)
                }
            }
            
            // trace other parallele lines
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touche in touches {
            
            if let index = fingers.indexForKey(touche.hashValue) {
                // Removing old traced lines for this finger
                removeLinesForThisFinger(touche.hashValue)
                
                // Forgeting about this finger
                fingers.removeAtIndex(index)
            }

        }
    }
    
    func traceLinesForThisMove(fingerHashValue: Int, startPoint: CGPoint, endPoint: CGPoint) -> [String]? {
        var linePathnames = [String]()
        
        // first line
        let path = UIBezierPath()
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        path.lineWidth = attachmentStrokeWidth
        let pathname = "\(fingerHashValue)"
        
        self.coolSceneView.setPath(path, named: pathname, preferedColor: UIColor.redColor())
        linePathnames.append(pathname)
        
        // get the angle
        var angle = startPoint.angleToPoint(endPoint)
        
       
        
        let atanValue = atan2((endPoint.x - startPoint.x), (endPoint.y - startPoint.y))
        let lineAngle = Double(atanValue * 180) / M_PI
        
        print("angle : \(angle)")
        print("lineAngle : \(lineAngle)")
        
        // get the final point ?
        let endX = cos(lineAngle) * 50 + Double(endPoint.y)
        let endY = sin(lineAngle) * 50 + Double(endPoint.x)
        let finalPoint = CGPoint(x: endX, y: endY)
        
        // second line
        let secondPath = UIBezierPath()
        secondPath.moveToPoint(endPoint)
        secondPath.addLineToPoint(finalPoint)
        secondPath.lineWidth = attachmentStrokeWidth * 3
        let secondPathname = "\(fingerHashValue * 2)"
        
        self.coolSceneView.setPath(secondPath, named: secondPathname, preferedColor: UIColor.blueColor())
        linePathnames.append(secondPathname)
        return linePathnames
    }
    
    func removeLinesForThisFinger(toucheHashValue: Int) {
        
        if let idx = oldLinePathnames.indexForKey(toucheHashValue) {
            let linesTracedForThisTouch = oldLinePathnames[idx]
            for linePathnames in linesTracedForThisTouch.1 {
                self.coolSceneView.setPath(nil, named: linePathnames)
            }
            oldLinePathnames.removeAtIndex(idx)
        }
    }
}

extension CGPoint {
    func angleToPoint(comparisonPoint: CGPoint) -> CGFloat {
        let originX = comparisonPoint.x - self.x
        let originY = comparisonPoint.y - self.y
        let bearingRadians = atan2f(Float(originY), Float(originX))
        var bearingDegrees = CGFloat(bearingRadians).degrees
        while bearingDegrees < 0 {
            bearingDegrees += 360
        }
        return bearingDegrees
    }
}

extension CGFloat {
    var degrees: CGFloat {
        return self * CGFloat(90.0 / M_PI)
    }
}
