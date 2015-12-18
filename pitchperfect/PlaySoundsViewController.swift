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
    var audioURL : NSURL!
    var receivedAudio : RecordedAudio!
    var audioEngine : AVAudioEngine!
    var audioFile : AVAudioFile!
    var pitchPlayer : AVAudioPlayerNode!
    var timePitch : AVAudioUnitTimePitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()

        if let audioPath = NSBundle.mainBundle().pathForResource("movie_quote",ofType:"mp3") {
            
            let audioURL  = receivedAudio == nil ? NSURL.fileURLWithPath( audioPath) : receivedAudio.filePathUrl
            do {
                audioPlayer = try AVAudioPlayer( contentsOfURL: audioURL)
                audioPlayer.volume = 1
                audioPlayer.enableRate  = true
                audioFile = try? AVAudioFile(forReading: audioURL)
                
                
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
  
    @IBAction func playDarthVaderSound(sender: AnyObject) {
        playVariablePitchSound(-1000)
        
        print("play Darth Vader sound")
    }
    @IBAction func playFastSound(sender: AnyObject) {
        audioPlayer.currentTime = 0
        audioPlayer.rate = 2
        audioPlayer.stop()
        if( audioPlayer.play()) {
            print("Success: Play Fast Sound. Volume: \(audioPlayer.volume). ")
        }else{
            print("Failure: Play Fast Sound")
        }
        
    }
    @IBAction func playSlowSound(sender: AnyObject) {
        audioPlayer.currentTime = 0
        audioPlayer.rate = 0.5
        audioPlayer.stop()
        if( audioPlayer.play()) {
            print("Success: Play Slow Sound. Volume: \(audioPlayer.volume). ")
        }else{
            print("Failure: Play Slow Sound")
        }

        
        
    }
    func playVariablePitchSound(pitch : Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        if  audioFile != nil {
            pitchPlayer = AVAudioPlayerNode()
            timePitch = AVAudioUnitTimePitch()
            
            timePitch.pitch = pitch
            
            audioEngine.attachNode(pitchPlayer)
            audioEngine.attachNode(timePitch)
            
            audioEngine.connect(pitchPlayer, to: timePitch, format: audioFile.processingFormat)
            audioEngine.connect(timePitch, to: audioEngine.outputNode, format: audioFile.processingFormat)
            
            pitchPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
            
            if  ((try? audioEngine.start()) != nil)  {
                
                pitchPlayer.play()
                
            }else {
                
                print("Audio Engine can't start!")
            }
            
        }else{
            
            print("Audio File not found!")
            
        }
        
        print("play chipmunk sound")
        
    }
    @IBAction func playChipMunkSound(sender: UIButton) {
        playVariablePitchSound(1000)
    
    }
    @IBAction func stopPlayback(sender: AnyObject) {
        audioPlayer.stop()
        audioEngine.stop()
       
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
