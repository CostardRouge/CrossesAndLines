//
//  RandomyViewController.swift
//  Cool
//
//  Created by Steeve Pommier on 01/02/16.
//  Copyright © 2016 Steeve is working. All rights reserved.
//

import UIKit

class RandomyViewController: UIViewController, Experiment {
    
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
            
            let degrees = CGFloat.random(360)
            shape.transform = CGAffineTransformMakeRotation(degrees * CGFloat( M_PI/180))
            
            self.view.addSubview(shape)
            shapes.append(shape)
        }
    }
    
    // MARK: ExperimentProtocol
    static func getExperimentName() -> String {
        return "Randomy"
    }
    
    static func getExperimentAuthorName() -> String? {
        return "CostardRouge"
    }
    
    static func getExperimentDescription() -> String? {
        return "Actions without rationnal reasons"
    }
    
    static func getExperimentThumbnailImage() -> UIImage? {
        return UIImage(named: "Square")
    }
    
    static var preferedLabelColorForCell = UIColor.whiteColor()
}
