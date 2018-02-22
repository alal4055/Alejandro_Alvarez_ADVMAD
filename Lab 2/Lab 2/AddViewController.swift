//
//  AddViewController.swift
//  Lab 2
//
//  Created by Alejandro Alvarez on 2/21/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved./Volumes/Alvarez Backsup/AdvApp/labbbbs2/Lab 2/Lab 2/TableViewController.swift
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var fieldofText: UITextField!
    @IBOutlet weak var addingLabel: UILabel!
    
    var addHour = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "doneSegue"{
                if ((fieldofText.text?.isEmpty) == false){
                    addHour=fieldofText.text!
            }
        }
    }
    

}
