//
//  RandomyViewController.swift
//  Cool
//
//  Created by Steeve Pommier on 01/02/16.
//  Copyright © 2016 Steeve is working. All rights reserved.
//

import UIKit

class RandomyViewController: UIViewController {
    
    @IBOutlet weak var coolSceneView: BezierPathsView!
    
    var shapesCount: Int = 50
    var shapeStrokeWidth: CGFloat = 1.5
    
    var shapeSize: CGSize = CGSize(width: 30.0, height: 25.0)
    var shapes = [Triangle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRandomShapes()
    }
    
    func createRandomShapes() {
        for _ in 0...shapesCount {
            let maxX = Int(view.bounds.width)
            let maxY = Int(view.bounds.height)
            
            let shapePosition = CGPoint(x: CGFloat.random(maxX), y: CGFloat.random(maxY))
            let shapeFrame = CGRect(origin: shapePosition, size: shapeSize)
            let shape = Triangle(frame: shapeFrame)
            
            shape.color = UIColor.random
            shape.lineWidth = shapeStrokeWidth
            shape.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            
            // 
            let degrees = CGFloat.random(360)
            shape.transform = CGAffineTransformMakeRotation(degrees * CGFloat( M_PI/180))
            
            coolSceneView?.addSubview(shape)
            shapes.append(shape)
        }
    }
}
