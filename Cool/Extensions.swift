//
//  Extensions.swift
//  Cool
//
//  Created by Steeve Pommier on 13/03/16.
//  Copyright © 2016 Steeve is working. All rights reserved.
//

import UIKit
import Foundation

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
