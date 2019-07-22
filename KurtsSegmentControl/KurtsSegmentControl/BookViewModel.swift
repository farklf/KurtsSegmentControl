//
//  BookViewModel.swift
//  KurtsSegmentControl
//
//  Created by MAC Consultant on 7/21/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func updateView()
}

class ViewModel {
    
    weak var delegate: ViewModelDelegate?
    
    
    var myBooks = [Book](){
        didSet {
            delegate?.updateView()
        }
    }
    
    var currentBook: Book!
    
    func get(books: String?){
        
        BookService.shared.getBooks(book: books) { [weak self] books in
            
            if let bks =  books {
                self?.myBooks = bks
            }
        }
        
    }
    
    
}

