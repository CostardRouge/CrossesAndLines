//
//  NoNameViewController.swift
//  Cool
//
//  Created by Steeve Pommier on 05/03/16.
//  Copyright © 2016 Steeve is working. All rights reserved.
//

import UIKit

class NoNameViewController: UIViewController, Experiment {
    
    var shapesCount: Int = 75
    var shapeStrokeWidth: CGFloat = 1.0
    var offsetFactor:CGFloat = 1.0
    
    var shapeSize: CGSize = CGSize(width: 10.0, height: 10.0)
    var shapes = [Circle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //createRandomShapes()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        createRandomShapes()
        title = NoNameViewController .getExperimentName()
        view.backgroundColor = UIColor.blackColor()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        //createRandomShapes()
    }
    
    func createRandomShapes() {
        print(shapesCount)
        for x in 0...shapesCount {
            
            let shapePosition = CGPoint(x: view.center.x - (shapeSize.width / 2), y: view.center.y - (shapeSize.height / 2))
            let shapeFrame = CGRect(origin: shapePosition, size: shapeSize)
            let shape = Circle(frame: shapeFrame)
            
            shape.color = UIColor.random
            shape.color = BoxColors.red
            shape.lineWidth = shapeStrokeWidth
            shape.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
            
            self.view.addSubview(shape)
            shapes.append(shape)
    
            shapeSize = CGSize(width: 10.0 * (Double(x) * 0.8 ), height: 10.0 * Double(x))
        }
    }

    
    // MARK: ExperimentProtocol
    static func getExperimentName() -> String {
        return "Cercles"
    }
    
    static func getExperimentAuthorName() -> String? {
        return "CostardRouge"
    }
    
    static func getExperimentDescription() -> String? {
        return "Presque une spirale"
    }
    
    static func getExperimentThumbnailImage() -> UIImage? {
        return UIImage(named: "PasDeNom")
    }
    
    static var preferedLabelColorForCell = UIColor.whiteColor()
}
