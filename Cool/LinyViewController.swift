//
//  LinyViewController.swift
//  Liny
//
//  Created by Steeve is working on 03/12/15.
//  Copyright © 2015 Steeve is working. All rights reserved.
//

import UIKit

class LinyViewController: UIViewController, Experiment {
    
    var coolSceneView:BezierPathsView? = nil
    
    var crossesCount: Int = 250
    var crossStrokeWidth: CGFloat = 1.0
    var attachmentStrokeWidth: CGFloat = 1.0
    var preferedColorForCrosses: UIColor? = nil {
        didSet {
            createBezierPathsView()
            createRandomCrosses()
        }
    }
    
    var crossSize: CGSize = CGSize(width: 5.0, height: 5.0)
    var crosses = [Cross]()
    
    var lineRange: CGFloat = 150
    
    var fingers = [Int:CGPoint]()
    var oldLinePathnames = [Int:[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = LinyViewController.getExperimentName()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Color", style: UIBarButtonItemStyle.Plain, target: self, action: "showColorSelectionAlertView")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.blackColor()
        createBezierPathsView()
        createRandomCrosses()
    }
    
    func showColorSelectionAlertView() {
        print("showColorSelectionAlertView")
        
        let colorMenu = UIAlertController(title: nil, message: "Choose a color", preferredStyle: .ActionSheet)
        
        let redColorChoice = UIAlertAction(title: "Red", style: .Default) { (alert: UIAlertAction) -> Void in
            self.preferedColorForCrosses = UIColor.redColor()
        }
        
        let blueColorChoice = UIAlertAction(title: "Blue", style: .Default) { (alert: UIAlertAction) -> Void in
            self.preferedColorForCrosses = UIColor.blueColor()
        }
        
        let whiteColorChoice = UIAlertAction(title: "White", style: .Default) { (alert: UIAlertAction) -> Void in
            self.preferedColorForCrosses = UIColor.whiteColor()
        }
        
        let randomColorChoice = UIAlertAction(title: "Random one", style: .Default) { (alert: UIAlertAction) -> Void in
            self.preferedColorForCrosses = nil
        }
        
        let cancelAction = UIAlertAction(title: "Meh.", style: .Cancel) { (alert: UIAlertAction) -> Void in
            // nothing to do but believe
        }
        
        colorMenu.addAction(blueColorChoice)
        colorMenu.addAction(redColorChoice)
        colorMenu.addAction(randomColorChoice)
        colorMenu.addAction(whiteColorChoice)
        colorMenu.addAction(cancelAction)
        
        presentViewController(colorMenu, animated: true, completion: nil)
    }
    
    func applyCorrectBezierPathsViewConstraints() {
        if let loadedCoolSceneView = coolSceneView {
            let trailingContraint = NSLayoutConstraint(item: loadedCoolSceneView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0)
            view.addConstraint(trailingContraint)
            
            let leadingContraint = NSLayoutConstraint(item: loadedCoolSceneView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0)
            view.addConstraint(leadingContraint)
            
            let bottomContraint = NSLayoutConstraint(item: loadedCoolSceneView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
            view.addConstraint(bottomContraint)
            
            let topContraint = NSLayoutConstraint(item: loadedCoolSceneView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
            view.addConstraint(topContraint)
        }
    }
    
    func createRandomCrosses() {
        for _ in 0...crossesCount {
            let maxX = Int(view.bounds.width)
            let maxY = Int(view.bounds.height)
            
            let crossPosition = CGPoint(x: CGFloat.random(maxX), y: CGFloat.random(maxY))
            let crossFrame = CGRect(origin: crossPosition, size: crossSize)
            let cross = Cross(frame: crossFrame)
            cross.color = preferedColorForCrosses ?? UIColor.random
            cross.lineWidth = crossStrokeWidth
            cross.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            
            coolSceneView?.addSubview(cross)
            crosses.append(cross)
        }
    }
    
    func createBezierPathsView() {
        // Oh, it that a recreate call ?
        if coolSceneView != nil {
            coolSceneView!.removeFromSuperview()
        }
        
        coolSceneView = BezierPathsView()
        coolSceneView?.multipleTouchEnabled = true
        coolSceneView?.backgroundColor = UIColor.blackColor()
        coolSceneView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coolSceneView!)
        applyCorrectBezierPathsViewConstraints()
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
                self.coolSceneView?.setPath(nil, named: linePathnames)
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
                self.coolSceneView?.setPath(path, named: pathname, preferedColor: cross.color)
                
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
        return UIImage(named: "Lignes")
    }
    
    static var preferedLabelColorForCell = UIColor.whiteColor()
}