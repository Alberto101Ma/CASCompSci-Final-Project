//
//  TextViewController.swift
//  APIProject
//
//  Created by Alberto Mancarella on 6/4/20.
//  Copyright © 2020 Alberto Mancarella. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    var text = ""
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
        
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
