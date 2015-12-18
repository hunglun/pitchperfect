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
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            let recordedAudio  = RecordedAudio()
            recordedAudio.title = recorder.url.lastPathComponent
            recordedAudio.filePathUrl = recorder.url
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            if let  playSoundsVC: PlaySoundsViewController = segue.destinationViewController as? PlaySoundsViewController{
                if  let data = sender as? RecordedAudio{
                    playSoundsVC.receivedAudio = data
                }else{
                    print("sender is not recorded audio!")
                }
            }else{
                print("segue destination view controller is not PlaySoundsViewController!")
            }
        }
    }

    @IBAction func recordAudio(sender: AnyObject) {
        
        stopRecordingButton.hidden = false
        recordingInProgressLabel.hidden = false
        recordButton.enabled = false
        
        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
/*      let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
  */
        let recordingName = "pitchperfect.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        //        lastRecordedFilePath = filePath
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        recordingInProgressLabel.hidden = true
        recordButton.enabled = true
        //TODO: stop recording
        //Inside func stopAudio(sender: UIButton)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
  

}

