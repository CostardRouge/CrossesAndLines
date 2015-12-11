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
    var boxesOnHeight = 60
    
    var boxsStrokeWidth: CGFloat = 1.0
    var boxSize: CGSize = CGSize(width: 10.0, height: 10.0)
    var boxes = [Box]()
    
    static let timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRandomBoxes()
        
        
        // About box animations :
        // forever | one time, separatly | all together, static duration | random duration
        // static delay | random delay
        animateBoxColors(duration: 1.0, delay: 0.0)
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
    
    func animateBoxColors(duration duration: Double, delay: Double, forever: Bool = true, allTogether: Bool = true) {
        
        if allTogether {
            for box in boxes {
                
                UIView.animateWithDuration(duration, delay: delay, options: .CurveLinear, animations: { () -> Void in
                    box.backgroundColor = BoxColors.red
                    }) { (finished) -> Void in
                        if finished {
                            //self.animateBoxColors(duration: duration, delay: delay)
                        }
                }
            }
        }
        
        if forever {
            if allTogether {
                weak var wSelf = self
                
                let action = ObjectWrapper(value: {() -> () in
                    wSelf?.animateBoxColors(duration: duration, delay: delay, forever: forever, allTogether: allTogether)
                })
                
                performSelector("runClosure:", withObject: action, afterDelay: 1.0)
            }
            
        }
    }
    
    func runClosure(closure: AnyObject){
        if let close = closure as? ObjectWrapper<() -> ()> {
            close
            print(close)
        }
    }

}

class ObjectWrapper<T> {
    var value:T
    
    init(value:T) {
        self.value = value
    }
}


