//
//  BookSerialization.swift
//  KurtsSegmentControl
//
//  Created by MAC Consultant on 7/21/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import Foundation


//MARK: Serialization

enum MyErrors: Error {
    case missing(String)
}
enum CustomError: Error {
    case missing(String)
}


class Book: Decodable{
    
    var kind: String
    var id: String
    
    var thumbnail: String!
    
    
    //NOTE: init with a question mark means that it MAY fail, & if it does, throw an error
    init?(with json: [String:Any]) throws {
        
        guard let volumeInfo =  json["volumeInfo"] as? [String:Any] else {throw CustomError.missing("volumeInfo is missing")}
        guard let authors = volumeInfo["authors"] as? [String] else {throw  CustomError.missing("missing authors")}
        guard let imageLinks = volumeInfo["imageLinks"] as? [String:String] else {throw CustomError.missing("imageLinks is missing")}
        
        self.id = authors[0]
        
        self.kind = volumeInfo["title"] as! String
        self.thumbnail = imageLinks["thumbnail"]
        
    }
    
    
    
    
    
    
}

