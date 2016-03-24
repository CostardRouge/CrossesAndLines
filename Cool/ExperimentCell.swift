//
//  ExperimentCell.swift
//  Cool
//
//  Created by Steeve Pommier on 24/12/15.
//  Copyright © 2015 Steeve is working. All rights reserved.
//

import UIKit

class ExperimentCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var experimentDetail: ExperimentDetail? {
        didSet {
            configureCell()
        }
    }
    
    func configureCell() {
        if let loadedExperimentDetail = experimentDetail {
            nameLabel?.text = loadedExperimentDetail.name
            descriptionLabel?.text = loadedExperimentDetail.description 
        }
    }
    
}
