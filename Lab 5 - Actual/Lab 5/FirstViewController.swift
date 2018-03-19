//
//  FirstViewController.swift
//  Lab 5
//
//  Created by Alejandro Alvarez on 3/16/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class FirstViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    

    var workouts = [String]()
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        //define Google sign in button
        let googleSignInButton = GIDSignInButton()
        googleSignInButton.style = .wide
        googleSignInButton.center = view.center
        
        view.addSubview(googleSignInButton)
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user.authentication
            else {
                return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("The user logged in.")
    }
        
        //create a UIAlertController object
        let alert=UIAlertController(title: "Firebase", message: "Welcome " + (user?.profile.name)!, preferredStyle: UIAlertControllerStyle.alert)
        //create a UIAlertAction object for the button
        let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in

        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        if segue.identifier=="donesegue"{
            let source = segue.source as! AddViewController
            //add only if there is workout
            if ((source.addedWorkout.isEmpty) == false){
                //add to array
                workouts.append(source.addedWorkout)
                //add to firebase
                ref?.child("Workouts").childByAutoId().setValue(source.addedWorkout)
                /*
                tableView.reloadData()
                let chosenContinent = continentListDetail.continents[selectedContinent]
                //add country to our data model instance
                continentListDetail.continentData[chosenContinent]?.append(source.added
                    Country)
 */
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

