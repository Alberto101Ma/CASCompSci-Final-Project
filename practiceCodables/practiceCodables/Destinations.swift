//
//  Destinations.swift
//  practiceCodables
//
//  Created by Alberto Mancarella on 6/2/20.
//  Copyright © 2020 Alberto Mancarella. All rights reserved.
//

import Foundation

struct Destinations: Decodable{
    let addresses: Array<String>
    let origin: Array<String>
   // let rows: Rows
   
    
    
    
    private enum CodingKeys: String, CodingKey{
        case addresses = "destination_addresses"
        case origin = "origin_addresses"
       // case rows

        

    }
}

//
//struct Rows: Decodable{
//    let elements: String
//}
