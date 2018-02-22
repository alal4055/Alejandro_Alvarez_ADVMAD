//
//  ViewController.swift
//  Lab 2
//
//  Created by Alejandro Alvarez on 2/20/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var exerciseList = Exercise()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // URL for our plist
        if let pathURL = Bundle.main.url(forResource: "exercise", withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                exerciseList.exerciseData = try plistdecoder.decode([String: [String]].self, from: data)
                exerciseList.exercises = Array(exerciseList.exerciseData.keys)
            } catch {
                // handle error
                print(error)
            }
        }
       // print(plistdecoder)
        //print(exerciseList.exerciseData.keys)
        //print(exerciseList.exercises[0])
        //print("hello")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.exercises.count
    }

    //display cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = exerciseList.exercises[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "exercisesegue" {
            let tableVC = segue.destination as! TableViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            //sets the data for the destination controller
            tableVC.title = exerciseList.exercises[indexPath.row]
            tableVC.exerciseListTable = exerciseList
            tableVC.selectedExercise = indexPath.row
        }
            /*
            //for detail disclosure
        else if segue.identifier == "doneSegue"{
            let infoVC = segue.destination as! TableViewController
            let newCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: newCell)
            infoVC = exerciseList.exercises[indexPath!.row]
            //let hours = exerciseList.exerciseData[infoVC.hourTitle]! as [String]
            //infoVC.number = String(hours.count)
        }
 */
    }
}

