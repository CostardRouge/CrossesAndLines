//
//  Experiement.swift
//  Cool
//
//  Created by Steeve Pommier on 24/12/15.
//  Copyright © 2015 Steeve is working. All rights reserved.
//

import Foundation

class Experiment {
    let name: String
    let author: String?
    
    let description: String?
    let howToUseIt: String?
    
    let inspirationSource: String?
    let repositoryURL: String?
    
    let creationDate: NSDate?
    let lastVersionDate: NSDate?
    
    // tmp
    let segueIdentifier: String?
    let thumbnailImageNamed: String?
    
    init(name name_: String, description description_: String, author author_: String? = nil, segueIdentifier segue_dentifier: String? = nil) {
        name = name_
        author = author_
        description = description_
        
        howToUseIt = nil
        inspirationSource = nil
        repositoryURL = nil
        
        creationDate = nil
        lastVersionDate = nil
        
        // tmp
        segueIdentifier = segue_dentifier
        thumbnailImageNamed = nil
    }
}