//
//  SecondViewController.swift
//  Lab 5
//
//  Created by Alejandro Alvarez on 3/16/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit
import Firebase

class SecondViewController: UITableViewController {

    var ref: DatabaseReference!
    var workouts = [String]()
    var databaseHandle: DatabaseHandle?
    
    //didn't load the table view for some reason when I first signed in using Google, but worked after starting the app a second time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        
        //set up a listener for Firebase data change events
        //this event will fire with the initial data and then all data changes
        databaseHandle = ref?.child("Workouts").observe(DataEventType.value, with: {snapshot in
            self.workouts=[]
            print("in snapshot")
            //DataSnapshot represents the Firebase data at a given time
            //loop through all the child data nodes
            for workout in snapshot.children.allObjects as! [DataSnapshot]{
                let newWorkout = workout.value as? String
            print(newWorkout!)
                if let workoutValue = newWorkout{
                    self.workouts.append(workoutValue)
                    print(self.workouts)
                }
            }
            self.tableView.reloadData()
        })
    }

    //Number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
        return workouts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = workouts[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

