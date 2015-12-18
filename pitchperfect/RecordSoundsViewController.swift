//
//  RecordSoundsViewController.swift
//  pitchperfect
//
//  Created by hunglun on 14/12/15.
//  Copyright © 2015 hunglun. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController {
 
   
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

  
    @IBAction func recordAudio(sender: AnyObject) {
        
        stopRecordingButton.hidden = false
        recordingInProgressLabel.hidden = false
        recordButton.enabled = false
        //TODO: record audio
     
    
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        recordingInProgressLabel.hidden = true
        recordButton.enabled = true
        //TODO: stop recording
        
    }
  

}

