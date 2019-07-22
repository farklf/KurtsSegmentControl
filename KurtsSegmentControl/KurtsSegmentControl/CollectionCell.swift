//
//  CollectionCell.swift
//  KurtsSegmentControl
//
//  Created by MAC Consultant on 7/22/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {

    @IBOutlet weak var collectionImage: UIImageView!
    
    func setBook(book: Book) {
        
       
        
        //   bookthumbNail.image = book.thumbnail
        let url = URL(string: book.thumbnail)!
        print("am i here")
        print(url)
        URLSession.shared.dataTask(with: url) { (dat, _, _) in
            
            if let data = dat {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self.collectionImage.image = image
                        //          self.view.layoutIfNeeded()
                        print("Received Image")
                    }
                }
            }
            
            }.resume()
        
        
        
        
        
        
    }
    
    
    
    
    
}
