//
//  EphyViewController.swift
//  Cool
//
//  Created by Steeve Pommier on 11/02/16.
//  Copyright © 2016 Steeve is working. All rights reserved.
//

import UIKit

class EphyViewController: UIViewController, Experiment {

    var coolSceneView = BezierPathsView()
    var attachmentStrokeWidth: CGFloat = 0.5
    
    var fingers = [Int:CGPoint]()
    var oldLinePathnames = [Int:[String]]()
    var preferedColorForLines: UIColor? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = EphyViewController.getExperimentName()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Color", style: UIBarButtonItemStyle.Plain, target: self, action: "showColorSelectionAlertView")
    }
    
    func showColorSelectionAlertView() {
        print("showColorSelectionAlertView")
        
        let colorMenu = UIAlertController(title: nil, message: "Choose a color", preferredStyle: .ActionSheet)
        
        let redColorChoice = UIAlertAction(title: "Red", style: .Default) { (alert: UIAlertAction) -> Void in
            self.preferedColorForLines = UIColor.redColor()
        }
        
        let blueColorChoice = UIAlertAction(title: "Blue", style: .Default) { (alert: UIAlertAction) -> Void in
            self.preferedColorForLines = UIColor.blueColor()
        }
        
        let whiteColorChoice = UIAlertAction(title: "White", style: .Default) { (alert: UIAlertAction) -> Void in
            self.preferedColorForLines = UIColor.whiteColor()
        }
        
        let randomColorChoice = UIAlertAction(title: "Random one", style: .Default) { (alert: UIAlertAction) -> Void in
            self.preferedColorForLines = nil
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.blackColor()
        
        coolSceneView.multipleTouchEnabled = true
        coolSceneView.backgroundColor = UIColor.blackColor()
        coolSceneView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coolSceneView)
        
        let trailingContraint = NSLayoutConstraint(item: coolSceneView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0)
        view.addConstraint(trailingContraint)
        
        let leadingContraint = NSLayoutConstraint(item: coolSceneView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0)
        view.addConstraint(leadingContraint)
        
        let bottomContraint = NSLayoutConstraint(item: coolSceneView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        view.addConstraint(bottomContraint)
        
        let topContraint = NSLayoutConstraint(item: coolSceneView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
        view.addConstraint(topContraint)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        for touche in touches {
            let point = touche.locationInView(coolSceneView)
            fingers.updateValue(point, forKey: touche.hashValue)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        for touche in touches {
            if let index = fingers.indexForKey(touche.hashValue) {
                
                let firstFinger = fingers[index]
                let firstPoint = firstFinger.1
                
                let toucheMovedPoint = touche.locationInView(coolSceneView)
                
                
                var oldLinePathnamesTracedForThisTouch:[String]?
                
                if let idx = oldLinePathnames.indexForKey(touche.hashValue) {
                    let oldLinesTracedForThisTouch = oldLinePathnames[idx]
                    oldLinePathnamesTracedForThisTouch = oldLinesTracedForThisTouch.1
                    
                    print("oldLinePathnamesTracedForThisTouch \(oldLinePathnamesTracedForThisTouch?.count)")
                }
                
                if let newLinePathnames = traceLinesForThisMove(firstPoint, endPoint: toucheMovedPoint) {
                    
                    var wholeLinePathnamesForThisTouch = oldLinePathnamesTracedForThisTouch ?? [String]()
                    
                    wholeLinePathnamesForThisTouch.insertContentsOf(wholeLinePathnamesForThisTouch, at: 0)
                    
                    
                    oldLinePathnames.updateValue(wholeLinePathnamesForThisTouch, forKey: touche.hashValue)
                    print(newLinePathnames.count)
                }
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
    
    func traceLinesForThisMove(startPoint: CGPoint, endPoint: CGPoint) -> [String]? {
        var linePathnames = [String]()
        
        // first line
        let path = UIBezierPath()
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        path.lineWidth = attachmentStrokeWidth
        let pathname = "\(path.hashValue)"
        
        self.coolSceneView.setPath(path, named: pathname, preferedColor: preferedColorForLines ?? UIColor.random)
        
        linePathnames.append(pathname)
        return linePathnames
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
    
    // MARK: ExperimentProtocol
    static func getExperimentName() -> String {
        return "Éphemère"
    }
    
    static func getExperimentAuthorName() -> String? {
        return "CostardRouge"
    }
    
    static func getExperimentDescription() -> String? {
        return "Blablabla description ici"
    }
    
    static func getExperimentThumbnailImage() -> UIImage? {
        return UIImage(named: "Ephy")
    }
    
    static var preferedLabelColorForCell = UIColor.whiteColor()
}