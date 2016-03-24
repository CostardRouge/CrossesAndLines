//
//  NetyViewController.swift
//  Cool
//
//  Created by Steeve Pommier on 11/03/16.
//  Copyright © 2016 Steeve is working. All rights reserved.
//

import UIKit

class NetyViewController: UIViewController, Experiment {
    
    var crossSize: CGSize = CGSize(width: 10, height: 10)
    var crossStrokeWidth: CGFloat = 1.0
    
    var crossHeightOffset: CGFloat = 6.0
    var crossWidthOffset: CGFloat = 10.0
    
    var lineRange: CGFloat = 15
    
    var fingers = [Int:CGPoint]()
    
    var crossesOnWidth: Int {
        get {
            return Int(windowWidth() / (crossWidthOffset + crossSize.width))
        }
    }
    
    var crossesOnHeight: Int {
        get {
            return Int(windowHeight() / (crossHeightOffset + crossSize.height))
        }
    }
    
    func windowHeight() -> CGFloat {
        return UIScreen.mainScreen().bounds.height
    }
    
    func windowWidth() -> CGFloat {
        return UIScreen.mainScreen().bounds.width
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        disposeTheCrosses()
        
        view.backgroundColor = UIColor.whiteColor()
        title = NetyViewController.getExperimentName()
    }
    
    func disposeTheCrosses(crossesPreferedColor: UIColor? = nil) {
        for y in 0...crossesOnHeight {
            let positionOnY = CGFloat(y) * (crossHeightOffset + crossSize.height)
            let rowOffset:CGFloat = (y % 2 == 1 ? 0.0 : crossWidthOffset)
            
            for x in 0...crossesOnWidth {
                let positionOnX = CGFloat(x) * (crossWidthOffset + crossSize.width) + rowOffset
                
                let crossPosition = CGPoint(x: positionOnX, y: positionOnY)
                let crossFrame = CGRect(origin: crossPosition, size: crossSize)
                let cross = Cross(frame: crossFrame)
                cross.haveToBeVerticallyDrawn = (x % 4 == 1 ? false : true)
                //cross.haveToBeVerticallyDrawn = true
                cross.color = crossesPreferedColor ?? UIColor.blueColor()
                cross.lineWidth = crossStrokeWidth
                cross.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
                
                view.addSubview(cross)
                
                if x % 4 == 1 {
                    cross.color = UIColor.redColor()
                }
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        for touche in touches {
            let point = touche.locationInView(view)
            fingers.updateValue(point, forKey: touche.hashValue)
            
            if let crosses = getCrossesNearOf(point, range: lineRange) {
                for cross in crosses {
                    cross.color = UIColor.purpleColor()
                    cross.haveToBeVerticallyDrawn = false
                }
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        for touche in touches {
            let point = touche.locationInView(view)
            fingers.updateValue(point, forKey: touche.hashValue)
            
            if let crosses = getCrossesNearOf(point, range: lineRange) {
                for cross in crosses {
                    cross.color = UIColor.greenColor()
                    
                    //cross.backgroundColor = UIColor.purpleColor()
                    cross.haveToBeVerticallyDrawn = false
                }
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touche in touches {
            if let index = fingers.indexForKey(touche.hashValue) {
                // Removing old traced lines for this finger
                //removeLinesForThisFinger(touche.hashValue)
                
                // Forgeting about this finger
                fingers.removeAtIndex(index)
            }
        }
    }
    
    func getCrossesNearOf(point: CGPoint, range: CGFloat = 150) -> [Cross]? {
        var result = [Cross]()
        
        for subview in view.subviews {
            if let cross = subview as? Cross {
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
        }
        return result.count > 0 ? result : nil
    }

    // MARK: ExperimentProtocol
    static func getExperimentName() -> String {
        return "Fillet"
    }
    
    static func getExperimentAuthorName() -> String? {
        return "CostardRouge"
    }
    
    static func getExperimentDescription() -> String? {
        return "Demo of an animated pattern"
    }
    
    static func getExperimentThumbnailImage() -> UIImage? {
        return UIImage(named: "Fillet")
    }
    
    static var preferedLabelColorForCell = UIColor.blackColor()

}
