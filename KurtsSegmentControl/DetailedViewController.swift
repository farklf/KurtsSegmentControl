//
//  DetailedViewController.swift
//  KurtsSegmentControl
//
//  Created by MAC Consultant on 7/21/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//


import UIKit

class DetailedViewController: UIViewController {
   
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    
    @IBOutlet weak var bookKindLabel: UILabel!
    
    
    @IBOutlet weak var bookIdLabel: UILabel!
    
    var viewModel: ViewModel!
    
    var kind: String!
    var id:   String!
    
    var thumbnail: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookKindLabel.text = viewModel.currentBook.kind
        bookIdLabel.text = viewModel.currentBook.id
       
        
        
        
        
        let url = URL(string: viewModel.currentBook.thumbnail)!
        
        URLSession.shared.dataTask(with: url) { (dat, _, _) in
            
            if let data = dat {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self.thumbnailImage.image = image
                        self.view.layoutIfNeeded()
                        print("Received Image")
                    }
                }
            }
            
            }.resume()
    }
    
    
    
    
}
