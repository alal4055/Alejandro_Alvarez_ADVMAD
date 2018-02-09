//
//  ThirdViewController.swift
//  DDRace
//
//  Created by Alejandro Alvarez on 2/8/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import UIKit
import AVFoundation

class ThirdViewController: UIViewController {

    
    @IBOutlet weak var humanButton: UIButton!
    
    @IBOutlet weak var orcButton: UIButton!
    
    var player:AVAudioPlayer = AVAudioPlayer()
    
    @IBAction func humanPlay(_ sender: Any) {
        let audioPath = Bundle.main.path(forResource: "humansound", ofType: "mp3")
        do{
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!)as URL)
        }
        catch{
            //error
        }
        player.play()
    
    }
    
    @IBAction func orcPlay(_ sender: Any) {
            let audioPath = Bundle.main.path(forResource: "orcsound", ofType: "wav")
        do{
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!)as URL)
        }
        catch{
            //error
        }
            player.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
