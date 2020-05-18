//
//  ViewController.swift
//  APIProject
//
//  Created by Alberto Mancarella on 5/13/20.
//  Copyright © 2020 Alberto Mancarella. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var list: [Reddit] = [Reddit]()

    override func viewDidLoad() {
        super.viewDidLoad()
        catchdata()
        imageUpload()
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
                            //str.hasSuffix("ground")
                            //let movies: String = dictionary["results"] as? String
                        }
                    }
            }
        // Do any additional setup after loading the view.
    }
    
    
    func imageUpload(){
        let url = URL(string: "https://a.thumbs.redditmedia.com/onu_FG3ghceYb792agWK-rlUpPbEscif8P-3rdw3eX4.jpg")
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                     >> RoundCornerImageProcessor(cornerRadius: 20)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }


}

