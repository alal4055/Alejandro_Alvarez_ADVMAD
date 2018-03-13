//
//  ThirdViewController.swift
//  Project 1
//
//  Created by Alejandro Alvarez on 3/8/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ThirdViewController: UITableViewController {

    var charactersList = Characters()
    var addedRating = String()
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return charactersList.characterData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let characterVariables = charactersList.characterData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = (characterVariables["name"]!)
        var cellWidth = cell.frame.width - 5
        let buttonCinco : UIButton = UIButton.init(type: UIButtonType.roundedRect)
        buttonCinco.frame = CGRect(x:cellWidth,y:1,width:30,height:30)
        buttonCinco.addTarget(self, action: #selector(buttonFive(sender:)), for: .touchUpInside)
        buttonCinco.setTitle("5", for: .normal)
        buttonCinco.tag = indexPath.row
        cell.contentView.addSubview(buttonCinco)
        cellWidth = cellWidth - 30
        let buttonCuatro : UIButton = UIButton.init(type: UIButtonType.roundedRect)
        buttonCuatro.frame = CGRect(x:cellWidth,y:1,width:30,height:30)
        buttonCuatro.addTarget(self, action: #selector(buttonFour(sender:)), for: .touchUpInside)
        buttonCuatro.setTitle("4", for: .normal)
        buttonCuatro.tag = indexPath.row
        cell.contentView.addSubview(buttonCuatro)
        cellWidth = cellWidth - 30
        let buttonTres : UIButton = UIButton.init(type: UIButtonType.roundedRect)
        buttonTres.frame = CGRect(x:cellWidth,y:1,width:30,height:30)
        buttonTres.addTarget(self, action: #selector(buttonThree(sender:)), for: .touchUpInside)
        buttonTres.setTitle("3", for: .normal)
        buttonTres.tag = indexPath.row
        cell.contentView.addSubview(buttonTres)
        cellWidth = cellWidth - 30
        let buttonDos : UIButton = UIButton.init(type: UIButtonType.roundedRect)
        buttonDos.frame = CGRect(x:cellWidth,y:1,width:30,height:30)
        buttonDos.addTarget(self, action: #selector(buttonTwo(sender:)), for: .touchUpInside)
        buttonDos.setTitle("2", for: .normal)
        buttonDos.tag = indexPath.row
        cell.contentView.addSubview(buttonDos)
        cellWidth = cellWidth - 30
        let buttonUno : UIButton = UIButton.init(type: UIButtonType.roundedRect)
        buttonUno.frame = CGRect(x:cellWidth,y:1,width:30,height:30)
        buttonUno.addTarget(self, action: #selector(buttonOne(sender:)), for: .touchUpInside)
        buttonUno.setTitle("1", for: .normal)
        buttonUno.tag = indexPath.row
        cell.contentView.addSubview(buttonUno)
        
        /*
        let button = UIButton(frame: CGRect(x: 400, y: 100, width: 30, height: 30))
        button.backgroundColor = .green
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: Selector(("buttonAction")), for: .touchUpInside)
        
        self.view.addSubview(button)
        //cell.detailTextLabel?.text = "5"
        //cell.imageView?.image =
 */
        return cell
    }
    
    @objc func buttonFive(sender: UIButton) {
        print("test 5")
        let position = sender.tag
        vote(position: position, rating: 5)
    }
    
    @objc func buttonFour(sender: UIButton) {
        print("test 4")
        let position = sender.tag
        vote(position: position, rating: 4)
    }
    
    @objc func buttonThree(sender: UIButton) {
        print("test 3")
        let position = sender.tag
        vote(position: position, rating: 3)
    }
    
    @objc func buttonTwo(sender: UIButton) {
        print(sender.tag)
        let position = sender.tag
        vote(position: position, rating: 2)
    }
    
    @objc func buttonOne(sender: UIButton) {
        print(sender.tag)
        let position = sender.tag
        vote(position: position, rating: 1)
    }
    
    func vote(position: Int, rating: Int){
        var addPerson = String();
        if(position == 0){
            addPerson = "Jim Halpert";
        }
        else if(position == 1){
            addPerson = "Michael Scott"
        }
        else if(position == 2){
            addPerson = "Dwight Schrute"
        }
        else if(position == 3){
            addPerson = "Pam Beesly"
        }
        else if(position == 4){
            addPerson = "Ryan Howard"
        }
        else if(position == 5){
            addPerson = "Andy Bernard"
        }
        else if(position == 6){
            addPerson = "Robert California"
        }
        else if(position == 7){
            addPerson = "Kevin Malone"
        }
        else if(position == 8){
            addPerson = "Meredith Palmer"
        }
        else if(position == 9){
            addPerson = "Angela Martin"
        }
        else if(position == 10){
            addPerson = "Oscar Martinez"
        }
        else if(position == 11){
            addPerson = "Phylis Vance"
        }
        else{
            addPerson = "Darryl Philbin"
        }
        
        ref?.child(addPerson).childByAutoId().setValue(rating)
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
