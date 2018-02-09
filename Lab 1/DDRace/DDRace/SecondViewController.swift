//
//  SecondViewController.swift
//  DDRace
//
//  Created by Alejandro Alvarez on 2/1/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var Calculate: UIButton!
    
    
    @IBAction func DDCalculate(_ sender: Any) {
        //check to see if there's an app installed to handle this URL scheme
        if(UIApplication.shared.canOpenURL(URL(string: "calculator://")!)){
            //open the app with this URL scheme
            UIApplication.shared.open(URL(string: "calculator://")!, options: [:], completionHandler: nil)
        }else {
                UIApplication.shared.open(URL(string: "http://www.calculator.com/")!, options: [:], completionHandler: nil)
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

