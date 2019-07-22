//
//  bookApi.swift
//  KurtsSegmentControl
//
//  Created by MAC Consultant on 7/21/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import Foundation



struct bookAPI {
    
    static let base = "https://www.googleapis.com/books/v1/volumes?q="
    
    
    static func bookSearchURL(from search: String) -> String{
        
        return base + search
    }
    
}
