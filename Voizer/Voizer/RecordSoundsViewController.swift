//
//  RecordSoundsViewController.swift
//  Voizer
//
//  Created by Jennifer McCann on 3/19/15.
//  Copyright (c) 2015 Dad and Caden. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    //Outlet for the "Recording in Progress" label
    @IBOutlet weak var RecordingInProgress: UILabel!
    //Outlet for the Stop Button visibility
    @IBOutlet weak var StopButton: UIButton!
    //Outlet for the Record Button visibility
    @IBOutlet weak var RecordButton: UIButton!
    //Outlet for the "press to record" label
    @IBOutlet weak var PressToRecord: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //Hide Stop Button on start up
        StopButton.hidden = true
        
        
    }

    @IBAction func RecordAudio(sender: UIButton) {
        //Hide recording in Progress Message until mic is pressed
        RecordingInProgress.hidden = false
        //Show stop button after recording starts
        StopButton.hidden = false
        //Diable microphone button after it is pressed
        RecordButton.enabled = false
        //Hide Press to record message after microphone is pressed
        PressToRecord.hidden = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
    
            //Save recorded Audio with this call

            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent)
        
            //Perform Segue
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            println("Recording was not successful")
            RecordButton.enabled = true
            StopButton.hidden = true
            
        }
       
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaysoundsviewcontrollerViewController = segue.destinationViewController as PlaysoundsviewcontrollerViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
        
    }
        
    @IBAction func StopRecording(sender: UIButton) {
        RecordingInProgress.hidden = true
        RecordButton.enabled = true
        PressToRecord.hidden = false
        
        //Function to stop audio recording
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
        

}





