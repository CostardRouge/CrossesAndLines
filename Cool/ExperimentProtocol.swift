//
//  ExperimentProtocol.swift
//  Cool
//
//  Created by Steeve Pommier on 13/03/16.
//  Copyright © 2016 Steeve is working. All rights reserved.
//

import UIKit
import Foundation

protocol Experiment {
    init()
    
    static func getExperimentName() -> String
    static func getExperimentAuthorName() -> String?
    static func getExperimentDescription() -> String?
    static func getExperimentThumbnailImage() -> UIImage?
    
    static var preferedLabelColorForCell: UIColor { get }
}