//
//  ViewController.swift
//  APIProject
//
//  Created by Alberto Mancarella on 5/13/20.
//  Copyright © 2020 Alberto Mancarella. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var inputReddit: UITextField!
    @IBOutlet weak var transitionButton: UIButton!
    @IBOutlet weak var RedditTitle: UILabel!
    @IBOutlet weak var RedditText: UILabel!
    @IBOutlet weak var pageNumber: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var label: UILabel!
    typealias MutipleValue = (title: String, thumbnail: String, text: String)
    var RedditInfo = [String: MutipleValue]()
    var curText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputReddit.delegate = self
        RedditTitle.text = ""
        transitionButton.isEnabled = false
        hide()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        RedditInfo.removeAll()
        catchdata(input: inputReddit.text!)
        imageView.isHidden = false
        self.view.endEditing(true)
        return false
    }
    
    
    
    @IBAction func searchReddit(_ sender: Any) {
        RedditInfo.removeAll()
        catchdata(input: inputReddit.text!)
        imageView.isHidden = false
        
    }
    
    func catchdata(input: String){
        if inputReddit.text == ""{
            transitionButton.isEnabled = false
            hide()
            RedditTitle.text = "You gotta type something!"
            return
        } else{
            let url: URL? = URL(string: "https://www.reddit.com/r/\(inputReddit.text!)/.json")
            if url == nil{
                return
            }
            let responseData: Data? = try? Data(contentsOf: url!)
            if let responseData = responseData {
                let json: Any? = try? JSONSerialization.jsonObject(with: responseData, options: [])
                if let json = json {
                    do{
                        let decodeReddit = try? JSONDecoder().decode(Reddit.self, from: responseData)
                        if decodeReddit == nil{
                            return
                        }
                        let children = decodeReddit!.data.children
                        if children.count == 0{
                            error()
                            
                            return
                        } else{
                            for x in 0...children.count-1 {
                                RedditInfo["post\(x)"] = MutipleValue(title: children[x].data.title, thumbnail: children[x].data.thumbnail, text: children[x].data.selftext)
                            }
                            
                            changeScreen(input: 0)
                            stepper.value = 1
                        }
                    }
                } else{
                }
            }
            if responseData == nil{
                error()
            }
        }
    }
    
    func changeScreen(input: Int){
        imageView.isHidden = false
        stepper.isHidden = false
        pageNumber.isHidden = false
        let post = RedditInfo["post\(input)"]
        RedditTitle.text = "\(post!.title)"
        RedditText.text = "\(post!.text)"
        if RedditText.text! != ""{
            transitionButton.isEnabled = true
            curText = RedditText.text!
        } else{
            transitionButton.isEnabled = false
        }
        var curImage = ("\(RedditInfo["post\(input)"]!.thumbnail)")
        var allKeys = (Array(RedditInfo.keys))
        let max = (allKeys.count - 1)
        pageNumber.text = "\(input+1)/\(max+1)"
        stepper.maximumValue = Double(max+1)
        stepper.minimumValue = 1
        if checkSuffix(word: "\(RedditInfo["post\(input)"]!.thumbnail)") == true{
            imageView.image = nil
            setImage(from:"\(RedditInfo["post\(input)"]!.thumbnail)")
        }
        else{
            imageView.image = nil
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! TextViewController
        vc.text = self.curText
    }
    
    
    @IBAction func changePage(_ sender: UIStepper) {
        var allKeys = (Array(RedditInfo.keys))
        let max = (allKeys.count - 1)
        pageNumber.text = "\(Int(sender.value).description)/\(max+1)"
        changeScreen(input: Int(sender.value-1))
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            imageView.image = nil;
            return }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else {
                
                return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    
    func checkSuffix(word:String) -> Bool{
        if word.hasSuffix(".jpg"){
            return true
        } else{
            return false
        }
    }
    
    
    func error(){
        hide()
        RedditTitle.text = "Sub-Reddit Not Found!"
        transitionButton.isEnabled = false
    }
    
    func hide(){
        RedditText.text = ""
        imageView.image = nil
        pageNumber.isHidden = true
        stepper.isHidden = true
    }
}

