//
//  Reddit.swift
//  
//
//  Created by Alberto Mancarella on 5/28/20.
//

import Foundation



struct Reddit: Decodable {
    
    let kind: String
    let data: data
    
    private enum test: String, CodingKey{
        case data 
        case kind
    }
}

struct data: Decodable{
    let modhash: String
    let dist: Int
    let children: [Children]
}

struct Children: Decodable{
    let kind: String
    let data: AllData
}

struct AllData: Decodable{
    let thumbnail: String
    let title: String
    let selftext: String
}




