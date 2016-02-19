//
//  EphyViewController.swift
//  Cool
//
//  Created by Steeve Pommier on 11/02/16.
//  Copyright © 2016 Steeve is working. All rights reserved.
//

import UIKit

class EphyViewController: UIViewController {

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
                
                let toucheMovedPoint = touche.locationInView(coolSceneView)
                
                if let linePathnames = traceLinesForThisMove(firstPoint, endPoint: toucheMovedPoint) {
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
    
    func traceLinesForThisMove(startPoint: CGPoint, endPoint: CGPoint) -> [String]? {
        var linePathnames = [String]()
        
        // first line
        let path = UIBezierPath()
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        path.lineWidth = attachmentStrokeWidth
        let pathname = "\(path.hashValue)"
        
        self.coolSceneView.setPath(path, named: pathname, preferedColor: UIColor.redColor())
        
        linePathnames.append(pathname)
        
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