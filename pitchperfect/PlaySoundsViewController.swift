//
//  PlaySoundsViewController.swift
//  pitchperfect
//
//  Created by hunglun on 18/12/15.
//  Copyright © 2015 hunglun. All rights reserved.
//

import UIKit
import AVFoundation.AVAudioPlayer

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let audioPath = NSBundle.mainBundle().pathForResource("movie_quote",ofType:"mp3") {
            
            let audioURL  = NSURL.fileURLWithPath( audioPath)
            do {
                audioPlayer = try AVAudioPlayer( contentsOfURL: audioURL)
                audioPlayer.volume = 1
                audioPlayer.enableRate=true
               

            }
            catch {
                print("Ops! Audio Player fails to initialise.")
            }
        }else{
            print("Audio file can't be found")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playFastSound(sender: AnyObject) {
        audioPlayer.rate = 2
        audioPlayer.stop()
        if( audioPlayer.play()) {
            print("Success: Play Slow Sound. Volume: \(audioPlayer.volume). ")
        }else{
            print("Failure: Play Slow Sound")
        }
        
    }
    @IBAction func playSlowSound(sender: AnyObject) {
        //TODO: play slow sound
        audioPlayer.rate = 0.5
        audioPlayer.stop()
        if( audioPlayer.play()) {
            print("Success: Play Slow Sound. Volume: \(audioPlayer.volume). ")
        }else{
            print("Failure: Play Slow Sound")
        }

        
        
    }
    @IBAction func stopPlayback(sender: AnyObject) {
        audioPlayer.stop()
       
    }
    /*
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
