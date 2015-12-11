//
//  CubyViewController.swift
//  Cool
//
//  Created by Steeve Pommier on 11/12/15.
//  Copyright © 2015 Steeve is working. All rights reserved.
//

import UIKit

struct BoxColors {
    static var red: UIColor {
        get {
            let redValue = colorVariant.sample
            return UIColor(red: redValue, green: 0.039, blue: 0.1960, alpha: 1)
        }
    }
    
    static let colorVariant:[CGFloat] = [0.125, 0.25, 0.5, 0.75, 1]
}

class CubyViewController: UIViewController {
    var boxsStrokeWidth: CGFloat = 1.0
    var boxSize: CGSize = CGSize(width: 10.0, height: 10.0)
    var boxes = [Box]()
    
    // Animations
    var timer: NSTimer?
    var duration: Double = 3
    var delay: Double = 1
    var forever: Bool = true
    var allTogether: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRandomBoxes()
        
        // About box animations :
        // forever | one time, separatly | all together, static duration | random duration
        // static delay | random delay
        animateBoxes()
    }
    
    func createRandomBoxes() {
        let viewWidth = view.bounds.width
        let viewHeight = view.bounds.height
        
        let boxesOnWidth = Int(viewWidth / boxSize.width) + 1
        let boxesOnHeight = Int(viewHeight / boxSize.height) + 1
        let boxesCount = boxesOnWidth * boxesOnHeight
        
        print("expected boxs count: ", boxesCount)
        
        for y in 0...boxesOnHeight {
            
            for x in 0...boxesOnWidth {
                
                let x_position = x * Int(boxSize.width)
                let y_position = y * Int(boxSize.height)
                
                let boxPosition = CGPoint(x: x_position, y: y_position)
                let boxFrame = CGRect(origin: boxPosition, size: boxSize)
                let box = Box(frame: boxFrame)
                
                // Create a random value for red
                box.color = BoxColors.red
                box.y = y
                box.x = x
                
                view.addSubview(box)
                boxes.append(box)
                
            }
            
        }
    }
    
    func animateBoxes() {
        
        print("animateBoxes")
        
        if allTogether {
            for box in boxes {
                
                UIView.animateWithDuration(duration, delay: delay, options: .CurveLinear, animations: { () -> Void in
                    box.backgroundColor = BoxColors.red
                    }, completion: { (finished) -> Void in
                        if finished {
                            // finished
                        }
                })
            }
        }
        else {
            
            let randomElementsCount = boxes.count > 0 ? boxes.count / 1 : 0
            
            for box in boxes.randomElements(randomElementsCount) {
                UIView.animateWithDuration(duration, delay: delay, options: .CurveLinear, animations: { () -> Void in
                    box.backgroundColor = BoxColors.red
                    }, completion: { (finished) -> Void in
                        if finished {
                            // finished
                        }
                })
            }
        }
        
        if forever {
            if allTogether {
                performSelector("animateBoxes", withObject: nil, afterDelay: duration + delay)
            }
            else {
                performSelector("animateBoxes", withObject: nil, afterDelay: duration + delay)
            }
        }
    }
}
