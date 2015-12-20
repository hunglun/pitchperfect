//
//  RecordSoundsViewController.swift
//  pitchperfect
//
//  Created by hunglun on 14/12/15.
//  Copyright © 2015 hunglun. All rights reserved.
//

import UIKit
import AVFoundation

//Declared Globally
var audioRecorder:AVAudioRecorder!


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
 
   
    @IBOutlet weak var recordingInProgressLabel: UILabel!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // hide stop button
        stopRecordingButton.hidden = true
        recordButton.enabled = true
        recordingInProgressLabel.text = "Tap to record"
        recordingInProgressLabel.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            let recordedAudio  = RecordedAudio(title: recorder.url.lastPathComponent, filePathUrl: recorder.url)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            // use force unwrapping of Optional, because the values are defined in audioRecorderDidFinishRecording.
            let  playSoundsVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            playSoundsVC.receivedAudio = sender as! RecordedAudio
        }
    }

    @IBAction func recordAudio(sender: AnyObject) {
        
        stopRecordingButton.hidden = false
        recordingInProgressLabel.text = "Recording ..."
        recordButton.enabled = false
        
        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "pitchperfect.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)

        print(filePath)

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])

        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        //Inside func stopAudio(sender: UIButton)
        recordingInProgressLabel.hidden = true
        recordButton.enabled = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
  

}

