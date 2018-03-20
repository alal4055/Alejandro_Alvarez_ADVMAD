//
//  SecondViewController.swift
//  Project 1
//
//  Created by Alejandro Alvarez on 2/27/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    @IBOutlet weak var factPicker: UIPickerView!
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var factDescription: UILabel!
    
    var charactersList = Characters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // URL for our plist
        if let pathURL = Bundle.main.url(forResource: "officecharacters", withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                charactersList.characterData = try plistdecoder.decode([[String:String]].self, from: data)
            } catch {
                // handle error
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return charactersList.characterData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print("Title: ")
        let characterVariables = charactersList.characterData[row]
        return characterVariables["name"]!
    }
    
    //Called when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let characterVariables = charactersList.characterData[row]
        factLabel.text=(characterVariables["name"]!)
        factDescription.text=(characterVariables["fact"]!)
        // nameImage.image=
        //print(characterVariables["name"]!)
        //nameImage.text=
        //writes the string with the row's content to the label
    }
    
}

