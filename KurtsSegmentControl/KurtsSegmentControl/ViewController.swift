//
//  ViewController.swift
//  KurtsSegmentControl
//
//  Created by MAC Consultant on 7/20/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableContainer: UIView!
    @IBOutlet weak var collectionContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            tableContainer.isHidden = false
            collectionContainer.isHidden = true
        default:
            tableContainer.isHidden = true
            collectionContainer.isHidden = false
        }
        
        
    }
    
}

