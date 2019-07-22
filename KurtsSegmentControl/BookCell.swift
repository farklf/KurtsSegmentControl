//
//  BookCell.swift
//  KurtsSegmentControl
//
//  Created by MAC Consultant on 7/21/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var bookthumbnail: UIImageView!
    
    @IBOutlet weak var bookKindLabel: UILabel!
    
    @IBOutlet weak var bookIdLabel: UILabel!
    
    
    func setBook(book: Book) {
        
        bookKindLabel.text = book.kind
        bookIdLabel.text = book.id
     
        //   bookthumbNail.image = book.thumbnail
        let url = URL(string: book.thumbnail)!
        print("am i here")
        print(bookthumbnail)
        URLSession.shared.dataTask(with: url) { (dat, _, _) in
            
            if let data = dat {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self.bookthumbnail.image = image
                        //          self.view.layoutIfNeeded()
                        print("Received Image")
                    }
                }
            }
            
            }.resume()
        
        
        
        
        
        
    }
    
    
    
    
    
}
