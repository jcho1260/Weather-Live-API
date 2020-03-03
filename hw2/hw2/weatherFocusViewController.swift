//
//  weatherFocusViewController.swift
//  hw2
//
//  Created by Jin Cho on 2/12/20.
//  Copyright © 2020 Jin Cho. All rights reserved.
//

import UIKit

class weatherFocusViewController: UIViewController {

    var weatherText:String = ""
    var cityImage:UIImage?
    var tempText:String = ""
    var sumText:String = ""
    var precipText:String = ""
   
    
    
    @IBOutlet weak var citImg: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var precip: UILabel!
    @IBOutlet weak var sum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        temp.text = tempText
        precip.text = precipText
        sum.text = sumText
        citImg.image = cityImage
        
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
