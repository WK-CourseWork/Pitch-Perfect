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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func recordaudieo(_ sender: Any) {
       recordingChanges(recordingLabel: "Recording in Progress", recordingButton: false, stopRecordingButton: true)
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
    
    @IBAction func stoprecording(_ sender: Any) {
        recordingChanges(recordingLabel: "Tap to Record", recordingButton: true, stopRecordingButton: false)
        audioRecorder.stop()
           let audioSession = AVAudioSession.sharedInstance()
           try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    func recordingChanges(recordingLabel:String, recordingButton:Bool, stopRecordingButton:Bool) {
        self.recordinglabel.text = recordingLabel
        self.stopRecordingButton.isEnabled = stopRecordingButton
        self.recordingButton.isEnabled = recordingButton
    }
}

