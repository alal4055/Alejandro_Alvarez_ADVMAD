//
//  ViewController.swift
//  Midterm1
//
//  Created by Alejandro Alvarez on 3/15/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var restaurantList =  Restaurants()
    var selectedRestaurant = 0
    var restaurants = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // URL for our plist
        if let pathURL = Bundle.main.url(forResource: "restaurants", withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                restaurantList.restaurantData = try plistdecoder.decode([[String:String]].self, from: data)
            } catch {
                // handle error
                print(error)
            }
        }
        //print(restaurantList.restaurantData)
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    //Required methods for UITableViewDataSource
    //Number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print(restaurantList.restaurantData.count)
        return restaurantList.restaurantData.count
    }
    
    // Displays table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        print(restaurantList.restaurantData[0])
        let restaurant = restaurantList.restaurantData[indexPath.row]
        let name = restaurant["name"]!
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt
        indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the country from the array
            restaurants.remove(at: indexPath.row)
            let chosenRestaurant = restaurantList.restaurantData[selectedRestaurant]
            //Delete from the data model instance
            //restaurantList.restaurantData[chosenRestaurant]?.remove(at: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantsegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let restaurant = restaurantList.restaurantData[indexPath.row]
                let url = restaurant["url"]!
                let name = restaurant["name"]!
                let controller = segue.destination as! DetailViewController
                controller.detailItem = url as AnyObject?
                controller.title = name
               // print(controller.detailItem)
                //controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

