//
//  TableViewController.swift
//  Lab 5 Extra Credit
//
//  Created by Alejandro Alvarez on 3/19/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {

    var realm : Realm! //Realm database instance
    var workoutsList: Results<Workouts> {
        get {
            return realm.objects(Workouts.self) //returns all workout objects from Realm
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("yes")
        
        //initialize the realm variable
        do {
            realm = try Realm()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func addWorkout(_ sender: Any) {
        let addAlert = UIAlertController(title: "New Workout", message: "Add a new item to the workout list", preferredStyle: .alert)
            //add textfield to the alert
            addAlert.addTextField(configurationHandler: {(UITextField) in })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        addAlert.addAction(cancelButton)
        let addItemButton = UIAlertAction(title: "Add", style: .default, handler: {(UIAlertAction)in
            // adds new item
            let newitem = addAlert.textFields![0] //gets textfield
            let newWorkoutItem = Workouts()//create new workout instance
            newWorkoutItem.name = newitem.text! //set name with what is in textfield
            newWorkoutItem.completed = false
            do {
            try self.realm.write({
            self.realm.add(newWorkoutItem) //add to realm database
            self.tableView.insertRows(at: [IndexPath.init(row: self.workoutsList.count-1, section:0)], with: .automatic) //inserts new row at the end of the table
            })
            } catch let error{
            print(error.localizedDescription)
            }
            })
        addAlert.addAction(addItemButton)
        present(addAlert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workoutsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let workoutItem = workoutsList[indexPath.row]
        cell.textLabel!.text = workoutItem.name
        cell.accessoryType = workoutItem.completed ? .checkmark : .none //set checkmark if bought

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workoutItem = workoutsList[indexPath.row]
        try! self.realm.write { //write to realm database
            workoutItem.completed = !workoutItem.completed
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let workoutItem = workoutsList[indexPath.row]
            try! self.realm.write {
                self.realm.delete(workoutItem) //delete from realm database
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
