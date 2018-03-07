//
//  ViewController.swift
//  Lab 4
//
//  Created by Alejandro Alvarez on 3/6/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   // var observation = [observations]()
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // loadjson()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func weatherButton(_ sender: Any) {
        weather()
    }
    
    func weather(){
        let session = URLSession.shared
        //let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=21d0e077e4f2d44e0050ea6740bbb29a")!
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Denver,us?&units=imperial&APPID=21d0e077e4f2d44e0050ea6740bbb29a")!
        let dataTask = session.dataTask(with: weatherURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error)
            } else {
                if let data = data {
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    print(dataString!)
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        if let myDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                            if let temperature = myDictionary.value(forKey: "temp") {
                                DispatchQueue.main.async {self.weatherLabel.text = "Current Denver temperature: \(temperature)°F"}
                            }
                        }
                        else {
                            print("No key")
                        }
                    }
                    else {
                        print("No JSON conversion")
                    }
                }
                else {
                    print("No data")
                }
            }
        }
        dataTask.resume()
    }
    
    /*
    func loadjson(){
        //let apiKey = "AIzaSyA0Vtyt8wSonenxlBCz8tNJnU-UZM3qNQI"
        //let urlPath = "http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=21d0e077e4f2d44e0050ea6740bbb29a"
        let urlPath = "http://api.aerisapi.com/observations/seattle,wa?client_id=LuqeN3jpv3udt7QrvOFdg&client_secret=wYZLDApe6xyIthVAhKD1jq7kESzi97h5Fptl8WhX"
        guard let url = URL(string: urlPath)
            else {
                print("url error")
                return
        }
        
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            //print(httpResponse)
            let statusCode = httpResponse.statusCode
            print(data!)
            guard statusCode == 200
                else {
                    print("file download error")
                    return
            }
            //download successful
            print("download complete")
            //let outputStr  = String(data: data!, encoding: String.Encoding.utf8) as String!
           // print(outputStr)
            DispatchQueue.main.async {self.parsejson(data!)}
        })
        //must call resume to run session
        session.resume()
    }
    
    
    
    
    func parsejson(_ data: Data){
        do{
            print("api")
            let api = try JSONDecoder().decode(API.self, from: data)
            print("api")
            print(api)
            print("api")
            print(api)
            for observations in api.ob{
                observation.append(observations)
            }
        }
        catch let jsonErr
        {
           // print(observation)
           print(jsonErr.localizedDescription)
            return
        }
        //reload the table data after the json data has been downloaded
        //tableView.reloadData()
       // print(observation)
    }
 */
 
}

