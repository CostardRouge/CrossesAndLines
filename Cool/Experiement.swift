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
    
    init(name name_: String, description description_: String, author author_: String? = nil) {
        name = name_
        author = author_
        description = description_
        
        howToUseIt = nil
        inspirationSource = nil
        repositoryURL = nil
        
        creationDate = nil
        lastVersionDate = nil
    }
}