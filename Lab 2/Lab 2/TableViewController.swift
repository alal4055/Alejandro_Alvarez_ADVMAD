//
//  TableViewController.swift
//  Lab 2
//
//  Created by Alejandro Alvarez on 2/21/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
    
    var hours = [String]()
    var filteredWords = [String]()
    var selectedExercise = 0
    var exerciseListTable = Exercise()
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //search results
        let resultsController = SearchViewController() //create an instance of our SearchResultsController class
        resultsController.allwords = hours //set the allwords property to our words array
        searchController = UISearchController(searchResultsController: resultsController)
        
        //search bar configuration
        searchController.searchBar.placeholder = "Enter a search number"
        //place holder text
        searchController.searchBar.sizeToFit() //sets appropriate size for the search bar
        tableView.tableHeaderView=searchController.searchBar //install the search bar as the table header
        searchController.searchResultsUpdater = resultsController
        print(exerciseListTable.exercises)
    }

    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            let before = segue.source as! AddViewController
            if ((before.addHour.isEmpty) == false){
                hours.append(before.addHour)
                tableView.reloadData()
                let picked = exerciseListTable.exercises[selectedExercise]
                exerciseListTable.exerciseData[picked]?.append(before.addHour)
            }
        }
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
        return hours.count
    }

    override func viewWillAppear(_ animated: Bool) {
        exerciseListTable.exercises = Array(exerciseListTable.exerciseData.keys)
        let picked = exerciseListTable.exercises[selectedExercise]
        hours = exerciseListTable.exerciseData[picked]! as [String]
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)

        cell.textLabel?.text = hours[indexPath.row]

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the hour
            hours.remove(at: indexPath.row)
            let picked = exerciseListTable.exercises[selectedExercise]
            exerciseListTable.exerciseData[picked]?.remove(at: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let movingRow = fromIndexPath.row //row being moved from origanl
        let goingRow = toIndexPath.row //row being moved to destination
        let movingHour = hours[movingRow] //row is being moved
        //move array around
        hours.remove(at: movingRow)
        hours.insert(movingHour, at: goingRow)
        //move in data model instance
        let picked = exerciseListTable.exercises[selectedExercise]
        exerciseListTable.exerciseData[picked]?.remove(at: movingRow)
        exerciseListTable.exerciseData[picked]?.insert(movingHour, at: goingRow)
    }
 

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
 

    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        segue.destinationViewController.exercisesegue
        // Pass the selected object to the new view controller.
    }
    */

}
