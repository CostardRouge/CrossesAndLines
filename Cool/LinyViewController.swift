//
//  LinyViewController.swift
//  Liny
//
//  Created by Steeve is working on 03/12/15.
//  Copyright © 2015 Steeve is working. All rights reserved.
//

import UIKit

class LinyViewController: UIViewController {
    
    @IBOutlet weak var coolSceneView: BezierPathsView!
    
    var crossesCount: Int = 500
    var crossStrokeWidth: CGFloat = 1.0
    var attachmentStrokeWidth: CGFloat = 0.5
    
    var crossSize: CGSize = CGSize(width: 5.0, height: 5.0)
    var crosses = [Cross]()
    
    var lineRange: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRandomCrosses()
        coolSceneView?.multipleTouchEnabled = true
    }
    
    func createRandomCrosses() {
        for _ in 0...crossesCount {
            let maxX = Int(view.bounds.width)
            let maxY = Int(view.bounds.height)
            
            let crossPosition = CGPoint(x: CGFloat.random(maxX), y: CGFloat.random(maxY))
            let crossFrame = CGRect(origin: crossPosition, size: crossSize)
            let cross = Cross(frame: crossFrame)
            //cross.color = UIColor.random
            cross.color = UIColor.redColor()
            cross.lineWidth = crossStrokeWidth
            cross.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            
            coolSceneView?.addSubview(cross)
            crosses.append(cross)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        let pointsInView = touches.map { $0.locationInView(coolSceneView) }
        traceLinesAround(pointsInView, range: lineRange)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        let pointsInView = touches.map { $0.locationInView(coolSceneView) }
        traceLinesAround(pointsInView, range: lineRange)
    }
    
    //UNUSED
    @IBAction func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .Began: break
        case .Changed:
            let gesturePoint = gestureRecognizer.locationInView(coolSceneView)
            traceLinesAround([gesturePoint], range: lineRange)
        case .Ended: break
        default: break
        }
    }
    
    func traceLinesAround(points: [CGPoint], range: CGFloat = 150) {
        struct StaticHolder {
            static var oldLinePathnames = [String]()
        }
        
        // Better way to do that
        for oldLinePathname in StaticHolder.oldLinePathnames {
            self.coolSceneView.setPath(nil, named: oldLinePathname)
        }
        StaticHolder.oldLinePathnames.removeAll()
        
        for point in points {
            print(point)
            if let nearestCrosses = getCrossesNearOf(point, range: range) {
                for cross in nearestCrosses {
                    let path = UIBezierPath()
                    path.moveToPoint(cross.center)
                    path.addLineToPoint(point)
                    path.lineWidth = attachmentStrokeWidth
                    let pathname = "\(cross.hashValue)"
                    self.coolSceneView.setPath(path, named: pathname, preferedColor: cross.color)
                    
                    StaticHolder.oldLinePathnames.append(pathname)
                }
            }
        }
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
}


// MARK: - Extensions
extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

extension UIColor {
    class var random: UIColor {
        switch arc4random()%5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.orangeColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.blackColor()
        }
    }
}

extension Array {
    var sample : Element { return isEmpty ? self as! Element : self[Int(arc4random_uniform(UInt32(count)))] }
    
    func randomElement() -> Element? {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
    func random() -> Element {
        let randomIndex = Int(rand()) % count
        return self[randomIndex]
    }
    
    func randomElements(time:Int = 10) -> [Element] {
        var elements = [Element]()
        
        for _ in 0...time {
            elements.append(self.sample)
        }
        return elements
    }
}
