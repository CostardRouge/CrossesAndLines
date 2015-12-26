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
    
    var experiment: Experiment? {
        didSet {
            configureCell()
        }
    }
    
    func configureCell() {
        if let loadedExperiment = experiment {
            nameLabel?.text = loadedExperiment.name
            descriptionLabel?.text = loadedExperiment.description
        }
    }
    
}
