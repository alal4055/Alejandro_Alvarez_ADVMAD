//
//  FourthViewController.swift
//  Project 1
//
//  Created by Alejandro Alvarez on 3/8/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FourthViewController: UITableViewController {
    var ref: DatabaseReference!
    var otherCounter = 0
    var charactersList = ["Jim Halpert","Michael Scott","Dwight Schrute","Pam Beesly","Ryan Howard","Andy Bernard","Robert California","Kevin Malone","Meredith Palmer","Angela Martin","Oscar Martinez","Phylis Vance","Darryl Philbin"]
    var vote = [Votes]()
    var voteIntegers = [0,0,0,0,0,0,0,0,0,0,0,0,0]
    var averageVotes = [0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //had tons of problems reading in the data for each of the value to then take an average of those values so I'm leaving it as is
        //the snapshot seemed to run everytime for each piece of data when I thought it would only run for each child
        takeAverage(addPerson: "Jim Halpert")
        takeAverage(addPerson: "Michael Scott")
        takeAverage(addPerson: "Dwight Schrute")
        takeAverage(addPerson: "Pam Beesly")
        takeAverage(addPerson: "Ryan Howard")
        takeAverage(addPerson: "Andy Bernard")
        takeAverage(addPerson: "Robert California")
        takeAverage(addPerson: "Kevin Malone")
        takeAverage(addPerson: "Meredith Palmer")
        takeAverage(addPerson: "Angela Martin")
        takeAverage(addPerson: "Oscar Martinez")
        takeAverage(addPerson: "Phylis Vance")
        takeAverage(addPerson: "Darryl Philbin")
        otherCounter = -1
        print("average votes are")
        print(averageVotes)
        print("averagetotal")
        print(averageVotes)
        self.tableView.reloadData()
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
        return charactersList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        //print(vote[indexPath.row])
        //let votes = vote[indexPath.row]
        cell.textLabel?.text = charactersList[indexPath.row]
        cell.detailTextLabel?.text = String(averageVotes[indexPath.row])
        //print("average")
        //print(averageVotes[indexPath.row])
        //cell.imageView?.image =
        return cell
    }

    
    func takeAverage(addPerson: String){
        print("take Average function")
        var counter = 0
        var totalVotes = 0
        var averageNumber = 0
        ref = Database.database().reference()
        var DatabaseHandle:DatabaseHandle?
       DatabaseHandle = ref?.child(addPerson).observe(DataEventType.childAdded, with: {snapshot in
            //print("value:")
           // print(snapshot.value)
            self.voteIntegers[counter] = snapshot.value as! Int
        print("voteinteger:")
            print(self.voteIntegers[counter])
            let newVote = snapshot.value as? String
            if let actualVote = newVote{
               // print("actualVote")
                //print(actualVote)
                self.voteIntegers.append(Int(actualVote)!)
            }
            for item in self.voteIntegers {
                averageNumber = self.voteIntegers[item] + averageNumber
                if(self.voteIntegers[item] != 0){
                    totalVotes = totalVotes + 1
                    //self.otherCounter = self.otherCounter + 1
                }
                //print("before")
                //print(averageNumber)
            }
        self.otherCounter = self.otherCounter + 1
        counter = counter+1
            print("next")
            averageNumber = averageNumber/totalVotes
        print(self.otherCounter)
        if(self.otherCounter <= 12){
            self.averageVotes[self.otherCounter] = averageNumber
        }
            print(self.averageVotes)
        print(counter)
            //print("after")
            //print(averageNumber)
            //self.averageVotes[self.otherCounter] = averageNumber
            self.tableView.reloadData()
    })
        //otherCounter = otherCounter + 1
        print("averageNumber")
        print(averageNumber)
        //return averageNumber
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
