//
//  ViewController.swift
//  APIProject
//
//  Created by Alberto Mancarella on 5/13/20.
//  Copyright © 2020 Alberto Mancarella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var list: [Reddit] = [Reddit]()

    override func viewDidLoad() {
        super.viewDidLoad()
        catchdata()
       
    }
        func catchdata(){
            print("test")
             let url: URL = URL(string: "https://www.reddit.com/r/PrequelMemes/.json")!
                let responseData: Data? = try? Data(contentsOf: url)
                if let responseData = responseData {
                    let json: Any? = try? JSONSerialization.jsonObject(with: responseData, options: [])
                    if let json = json {
                        let dictionary: [String: Any]? = json as? [String: Any]
                        if let dictionary = dictionary {
                            print(dictionary)
                            //let movies: String = dictionary["results"] as? String
                        }
                    }
            }
        // Do any additional setup after loading the view.
    }


}

