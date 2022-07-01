//
//  RecordSoundViewController.swift
//  Pitch Perfect
//
//  Created by Waylon Kumpe on 6/27/22.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder = AVAudioRecorder()
    
    @IBOutlet weak var recordinglabel: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    #warning("Mark-up notations missing. I marked the files up for future refrene")

//    MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }

//    MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    #warning("audio is mis-spelled and recordaudio function does not match naming conventions. Should be recordAudio (note the lower camel case)")
//    MARK: recordaudieo
    @IBAction func recordaudieo(_ sender: Any) {
       isRecording(true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    #warning("function name is not lower camel case")
//    MARK: stoprecording- button stop recording pressed
    @IBAction func stoprecording(_ sender: Any) {
        isRecording(false)
        audioRecorder.stop()
           let audioSession = AVAudioSession.sharedInstance()
           try! audioSession.setActive(false)
    }
    
//    MARK: audioRecorderDidFinishRecording
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
            
        }
        
    }

//    MARK: prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

    #warning("Below is how I would have done your recordingChanges function")
//    MARK: isRecording
    func isRecording(_ isRecording: Bool) {
        
        if isRecording {
            recordinglabel.text = "Recording in Progress"
        } else {
            recordinglabel.text = "Tap to Record"
        }
        // using the "!" signifies NOT or opposite. so recording button will be set to the opposite of isRecording
        recordingButton.isEnabled = !isRecording
        
        //and here we set stop recording to be the same as isRecording
        stopRecordingButton.isEnabled = isRecording
        
        //Now calling this function is much simpler. when your are recording just call isRecording(true) when not recording it would be isRecording(false).
    }
}

