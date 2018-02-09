//
//  FirstViewController.swift
//  DDRace
//
//  Created by Alejandro Alvarez on 2/1/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var racePicker: UIPickerView!
    
    
    @IBOutlet weak var raceDescription: UILabel!
    
    @IBOutlet weak var raceName: UILabel!
    
    var allRaces = [String: [String]]()
    var race = [String]()
    var raceWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let pathURL = Bundle.main.url(forResource: "DDrace", withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                allRaces = try plistdecoder.decode([String: [String]].self, from: data)
                race = Array(allRaces.keys)
                raceWords = allRaces[race[0]]! as [String]
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
            return race.count
        }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return race[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

       //let racerow = pickerView.selectedRow(inComponent: 0) //gets the selected row for the artist
        
        
        raceWords = allRaces[race[row]]!
        raceName.text="\(race[row])"
        raceDescription.text="\(raceWords[0])"
    }

}

