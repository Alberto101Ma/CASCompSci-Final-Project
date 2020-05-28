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
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var label: UILabel!
    
    var list: [Reddit] = [Reddit]()

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ""
        imageUpload()
        catchdata(input: "PrequelMemes")
    }


    @IBAction func searchReddit(_ sender: Any) {
        if searchInput.text == ""{
            label.text = "Please type something!"
        } else{
            catchdata(input: searchInput.text!)
        }
    }
    

            
      func catchdata(input: String){
                         
                          let urlString = "https://www.reddit.com/r/\(input)/.json"
                         let url = URL(string: urlString)
                     let session = URLSession.shared
                     let dataTask = session.dataTask(with: url!) { (data, response, error) in
                         
                         if error == nil && data != nil{
                             let decoder = JSONDecoder()
                             
                             do{
                            let thumbnails = try decoder.decode(Reddit.self, from: data!)
                             print(thumbnails)
                         }
                             catch{
                                 print("error in JSON Parsing")
             }
                        }
        }
        dataTask.resume()
    }
    
        // Do any additional setup after loading the view.
    
    
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

    func checkSuffix(word:String) -> Bool{
        if word.hasSuffix(".png"){
            return true
        } else{
            return false
        }
    }
}

