//
//  CubyViewController.swift
//  Cool
//
//  Created by Steeve Pommier on 11/12/15.
//  Copyright © 2015 Steeve is working. All rights reserved.
//

import UIKit

class CubyViewController: UIViewController {
    var boxesOnHeight = 60
    
    var boxsStrokeWidth: CGFloat = 1.0
    var boxSize: CGSize = CGSize(width: 50.0, height: 50.0)
    var boxes = [Box]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRandomBoxes()
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
                box.color = UIColor.random
                
                view.addSubview(box)
                boxes.append(box)
                
            }
            
        }
    }

}
