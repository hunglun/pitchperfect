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
        
        let audioURL  = receivedAudio.filePathUrl
        do {
            audioPlayer = try AVAudioPlayer( contentsOfURL: audioURL)
            audioPlayer.enableRate  = true
            audioFile = try? AVAudioFile(forReading: audioURL)
        }
        catch {
            print("Ops! Audio Player fails to initialise.")
        }
    
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func resetAudioPlayer(){
        audioEngine.reset()
        audioPlayer.currentTime = 0
    }
    func stopAudioPlayer(){
        audioPlayer.stop()
        audioEngine.stop()
    }
    func playVariableSpeedSound(rate: Float){
        stopAudioPlayer()
        resetAudioPlayer()
        
        audioPlayer.rate = rate
        if( audioPlayer.play()) {
            print("Success: Play Sound. Volume: \(audioPlayer.volume). ")
        }else{
            print("Failure: Play Sound")
        }
        
    
    }
    @IBAction func playFastSound(sender: AnyObject) {
        playVariableSpeedSound(2)
    }
    @IBAction func playSlowSound(sender: AnyObject) {
        playVariableSpeedSound(0.5)
    }

    func playVariablePitchSound(pitch : Float){

        stopAudioPlayer()
        resetAudioPlayer()
        
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
    @IBAction func playDarthVaderSound(sender: AnyObject) {
        playVariablePitchSound(-1000)
    }
    
    @IBAction func playChipMunkSound(sender: UIButton) {
        playVariablePitchSound(1000)
    
    }
    @IBAction func stopPlayback(sender: AnyObject) {
        stopAudioPlayer()
    }
   
}
