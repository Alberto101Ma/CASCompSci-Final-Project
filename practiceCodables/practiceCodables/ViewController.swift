//
//  ViewController.swift
//  practiceCodables
//
//  Created by Alberto Mancarella on 6/2/20.
//  Copyright © 2020 Alberto Mancarella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
        var jsonFileData: Data?
        var jsonFileString: String?

        // TODO: Come up with a better UI than just a single boring label.
        
        override func viewDidLoad() {
            super.viewDidLoad()
            if let fileUrl = Bundle.main.url(forResource: "places", withExtension: "json") {
                jsonFileData = try? Data(contentsOf: fileUrl)
                jsonFileString = try? String(contentsOf: fileUrl)
            }
 
            
            if let data = jsonFileData {

                do{
                    let employee = try? JSONDecoder().decode(Destinations.self, from: data)

                    
                    print(employee!.addresses)
                    print(employee!.origin)
                
                    

                }
                
                
                
                
            }
        }

    }

