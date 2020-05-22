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
            
             let url: URL? = URL(string: "https://www.reddit.com/r/\(input)/.json")
        //if url! == nil{
        //label.text = "Redit page not found!"
    //}
                let responseData: Data? = try? Data(contentsOf: url!)
                if let responseData = responseData {
                    let json: Any? = try? JSONSerialization.jsonObject(with: responseData, options: [])
                 
                    if let json = json {
                         //print(json)
                        let dictionary: [String: Any]? = json as? [String: Any]
                        //print(dictionary)
                        if let dictionary = dictionary{
                            var movies = dictionary["data"] as? [String: Any] //dictionary
                            var x = (movies?["children"] as! [[String: Any]] )
                            //work-in-progress
                          //  var y = x[thumbnail] as! [Any: String]
                         //   print(movies!)
                  
                        }
                    }
        }
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

