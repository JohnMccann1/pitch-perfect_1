//
//  PlaysoundsviewcontrollerViewController.swift
//  Voizer
//
//  Created by Jennifer McCann on 3/21/15.
//  Copyright (c) 2015 Dad and Caden. All rights reserved.
//

import UIKit
import AVFoundation



class PlaysoundsviewcontrollerViewController: UIViewController {
    
    


    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error:nil)
        
    

    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func playAudioWithVariablePitch(pitch: Float)
        //Function for pitch control in Chipmunk and Darth Buttons
    {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    func loadFactoryReverbPreset(LargeRoom: AVAudioUnitReverbPreset)
        
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        //var changeReverb = AVAudioUnitReverbPreset
        //changeReverb.reverb = reverb
        
        
        var filterParameters: AVAudioUnitEQFilterParameters!
        var level: Float
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
        
    }


    
    

    @IBAction func SlowPlay(sender: UIButton) {
        //Function to play voice slowly
        
        //Stop any playback that is in progress
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        //slow play rate control
        audioPlayer.rate = 0.5
        //Reset the playback to the beginning every time
        audioPlayer.currentTime = 0.0
        //begin playback
        audioPlayer.play()
        
 
    }
    @IBAction func FastPlay(sender: UIButton) {
        //function to play voice at a faster rate
        
        //Stop any playback that is in progress
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        //Control playback rate
        audioPlayer.rate = 2
        //Reset the playback to the beginning every time
        audioPlayer.currentTime = 0.0
        //begin playback
        audioPlayer.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        //Call the Chipmunk function and set the pitch
        playAudioWithVariablePitch(1500)
            
    }


    @IBAction func playDarth(sender: UIButton) {
        //Call the Darth function and set the pitch
        playAudioWithVariablePitch(-1000)
    
    }
    @IBAction func playReverb(sender: UIButton) {
       // loadFactoryReverbPreset(LargeRoom)
        
    }
    
    @IBAction func StopAudioPlayback(sender: UIButton) {
        //Function to enable Stop Button to cease all playback
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    

}
        

    


