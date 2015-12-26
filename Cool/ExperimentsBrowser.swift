//
//  ExperimentsBrowser.swift
//  Cool
//
//  Created by Steeve Pommier on 24/12/15.
//  Copyright © 2015 Steeve is working. All rights reserved.
//

import UIKit

private let reuseIdentifier = "experimentCell"
private let sectionHeaderIdentifier = "sectionHeader"
private let sectionFooterIdentifier = "sectionFooter"

class ExperimentsBrowser: UICollectionViewController {
    
    let graphicsExperiments: [Experiment] = [
        Experiment(name: "Lignes", description: "Lines traced around crosses"),
        Experiment(name: "Carrés", description: "Random animated squares"),
        Experiment(name: "Bulles", description: "Interactive colored bubbles"),
        
        Experiment(name: "Connexion", description: "Connecting some lines"),
        Experiment(name: "Gravité", description: "Objects are attracted where you tap"),
        Experiment(name: "Anomalie", description: "Sometimes there are conflicts"),
        Experiment(name: "Permutation", description: "Movements are continuous stills anywyay")
    ]
    
    let UIExperiments: [Experiment] = [
        Experiment(name: "Bouttons", description: "Lines around stuff"),
        Experiment(name: "Leviers", description: "Cubes around stuff"),
        Experiment(name: "Tuiles", description: "Cubes around stuff")
    ]
    
    var experiments: [String: [Experiment]]
    
    required init(coder: NSCoder) {
        experiments = [String: [Experiment]]()
        
        experiments["Graphics"] = graphicsExperiments
        experiments["Interfaces"] = UIExperiments
        
        super.init(coder: coder)!
    }
    
    func experimentForIndexPath(indexPath: NSIndexPath) -> Experiment? {
        let keys = [String](experiments.keys)
        let key = keys[indexPath.section]
        
        if let section = experiments[key] {
            return  section[indexPath.row]
        }
        return nil
    }
    
    func experimentsForSection(section: Int) -> [Experiment]? {
        let keys = [String](experiments.keys)
        let key = keys[section]
        
        if let section = experiments[key] {
            return section
        }
        return nil
    }
    
    func nameForSection(section: Int) -> String {
        let keys = [String](experiments.keys)
        let key = keys[section]
        return key
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return experiments.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let experimentsAtSection = experimentsForSection(section) {
            return experimentsAtSection.count
        }
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        if let experimentCell = cell as? ExperimentCell {
            experimentCell.experiment = experimentForIndexPath(indexPath)
            return experimentCell
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableView = UICollectionReusableView()
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderIdentifier, forIndexPath: indexPath)
            
            if let view = reusableView as? ExperimentCollectionSectionHeaderView {
                view.headlineLabel?.text = nameForSection(indexPath.section)
            }
            
        case UICollectionElementKindSectionFooter:
            reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: sectionFooterIdentifier, forIndexPath: indexPath)
            
            if let view = reusableView as? ExperimentCollectionSectionFooterView {
                if let experimentsForSection = experimentsForSection(indexPath.section) {
                    //if experimentsForSection
                    let count = experimentsForSection.count
                    view.footnoteLabel?.text = "\(count) experiment\(count > 1 ? "s" : "")"
                }
            }
        default: break
        }
        
        return reusableView
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
