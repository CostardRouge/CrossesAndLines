//
//  LinyViewController.swift
//  Liny
//
//  Created by Steeve is working on 03/12/15.
//  Copyright © 2015 Steeve is working. All rights reserved.
//

import UIKit

class LinyViewController: UIViewController, Experiment {
    
    @IBOutlet weak var coolSceneView: BezierPathsView!
    
    var crossesCount: Int = 250
    var crossStrokeWidth: CGFloat = 1.0
    var attachmentStrokeWidth: CGFloat = 1.0
    
    var crossSize: CGSize = CGSize(width: 5.0, height: 5.0)
    var crosses = [Cross]()
    
    var lineRange: CGFloat = 150
    
    var fingers = [Int:CGPoint]()
    var oldLinePathnames = [Int:[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRandomCrosses()
        coolSceneView?.multipleTouchEnabled = true
    }
    
    func createRandomCrosses() {
        for _ in 0...crossesCount {
            let maxX = Int(view.bounds.width)
            let maxY = Int(view.bounds.height)
            
            let crossPosition = CGPoint(x: CGFloat.random(maxX), y: CGFloat.random(maxY))
            let crossFrame = CGRect(origin: crossPosition, size: crossSize)
            let cross = Cross(frame: crossFrame)
            cross.color = UIColor.random
            //cross.color = UIColor.redColor()
            cross.lineWidth = crossStrokeWidth
            cross.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            
            coolSceneView?.addSubview(cross)
            crosses.append(cross)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        for touche in touches {
            let point = touche.locationInView(coolSceneView)
            fingers.updateValue(point, forKey: touche.hashValue)
            if let linePathnames = traceLinesAround(touche.hashValue, point: point, range: lineRange) {
                oldLinePathnames.updateValue(linePathnames, forKey: touche.hashValue)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        for touche in touches {
            let point = touche.locationInView(coolSceneView)
            fingers.updateValue(point, forKey: touche.hashValue)
            removeLinesForThisFinger(touche.hashValue)
            if let linePathnames = traceLinesAround(touche.hashValue, point: point, range: lineRange) {
                oldLinePathnames.updateValue(linePathnames, forKey: touche.hashValue)
            }
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
    
    func removeLinesForThisFinger(toucheHashValue: Int) {
    
        if let idx = oldLinePathnames.indexForKey(toucheHashValue) {
            let linesTracedForThisTouch = oldLinePathnames[idx]
            for linePathnames in linesTracedForThisTouch.1 {
                self.coolSceneView.setPath(nil, named: linePathnames)
            }
            oldLinePathnames.removeAtIndex(idx)
        }
    }
    
    func traceLinesAround(fingerHashValue: Int, point: CGPoint, range: CGFloat = 150) -> [String]? {
        var linePathnames: [String]?
        
        if let nearestCrosses = getCrossesNearOf(point, range: range) {
            linePathnames = [String]()
            for cross in nearestCrosses {
                let path = UIBezierPath()
                path.moveToPoint(cross.center)
                path.addLineToPoint(point)
                path.lineWidth = attachmentStrokeWidth
                let pathname = "\(cross.hashValue + fingerHashValue)"
                self.coolSceneView.setPath(path, named: pathname, preferedColor: cross.color)
                
                linePathnames!.append(pathname)
            }
        }
        return linePathnames
    }
    
    func getCrossesNearOf(point: CGPoint, range: CGFloat = 150) -> [Cross]? {
        var result = [Cross]()
        
        for cross in crosses {
            let crossFrame = cross.frame
            
            let x = cross.center.x - range / 2
            let y = cross.center.y - range / 2
            let w = crossFrame.width + range
            let h = crossFrame.height + range
            
            let crossRange = CGRectMake(x, y, w, h)
            
            if CGRectContainsPoint(crossRange, point) {
                result.append(cross)
            }
        }
        return result.count > 0 ? result : nil
    }
    
    // MARK: ExperimentProtocol
    static func getExperimentName() -> String {
        return "Lignes"
    }
    
    static func getExperimentAuthorName() -> String? {
        return "CostardRouge"
    }
    
    static func getExperimentDescription() -> String? {
        return "Lines traced around crosses"
    }
    
    static func getExperimentThumbnailImage() -> UIImage? {
        return UIImage(named: "Liny")
    }
    
    static var preferedLabelColorForCell = UIColor.whiteColor()
}