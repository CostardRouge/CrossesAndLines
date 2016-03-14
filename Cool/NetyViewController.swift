//
//  NetyViewController.swift
//  Cool
//
//  Created by Steeve Pommier on 11/03/16.
//  Copyright © 2016 Steeve is working. All rights reserved.
//

import UIKit

class NetyViewController: UIViewController, Experiment {
    
    @IBOutlet weak var coolSceneView: BezierPathsView!
    
    var crossSize: CGSize = CGSize(width: 5.0, height: 5.0)
    var crossStrokeWidth: CGFloat = 1.0
    var crosses = [Cross]()
    
    var crossHeightOffset: CGFloat = 6.0
    var crossWidthOffset: CGFloat = 10.0
    
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
    
    var xOffsetCentering: CGFloat {
        get {
            let totalWidthLength = CGFloat(crossesOnWidth) * crossWidthOffset
            return (coolSceneView.bounds.width - totalWidthLength) / 2
        }
    }
    
    var yOffsetCentering: CGFloat {
        get {
            let totalHeightLength = CGFloat(crossesOnHeight) * crossHeightOffset
            return (coolSceneView.bounds.height - totalHeightLength) / 2
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
        
        view.backgroundColor = UIColor.redColor()
        title = NetyViewController.getExperimentName()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //disposeTheCrosses(UIColor.redColor())
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        print("coolSceneView.bounds.width \(coolSceneView?.bounds.width)")
        print("coolSceneView.bounds.height \(coolSceneView?.bounds.height)")
        
        
        print("view.window?.frame.width \(view.window?.frame.width)")
        print("view.window?.frame.height \(view.window?.frame.height)")

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
                cross.color = crossesPreferedColor ?? UIColor.blueColor()
                cross.lineWidth = crossStrokeWidth
                cross.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
                
                coolSceneView?.addSubview(cross)
                //crosses.append(cross)
            }
        }
    }

    // MARK: ExperimentProtocol
    static func getExperimentName() -> String {
        return "Nety"
    }
    
    static func getExperimentAuthorName() -> String? {
        return "CostardRouge"
    }
    
    static func getExperimentDescription() -> String? {
        return "Demo of an animated pattern"
    }
    
    static func getExperimentThumbnailImage() -> UIImage? {
        return UIImage(named: "Square")
    }
    
    static var preferedLabelColorForCell = UIColor.blackColor()

}
