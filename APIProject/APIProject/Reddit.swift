//
//  Reddit.swift
//  
//
//  Created by Alberto Mancarella on 5/28/20.
//

import Foundation



struct Reddit: Decodable {
    
    let data: String
    let child: child
    
    private enum content: String, CodingKey{
       
        case data = "data"
        case child
    }
}

struct child: Decodable{
    let city: String
    
}
