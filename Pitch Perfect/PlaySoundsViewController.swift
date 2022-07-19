//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Waylon Kumpe on 6/29/22.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    @IBOutlet weak var slow: UIButton!
    @IBOutlet weak var chipmunk: UIButton!
    @IBOutlet weak var fast: UIButton!
    @IBOutlet weak var vader: UIButton!
    @IBOutlet weak var echo: UIButton!
    @IBOutlet weak var reverb: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var normal: UIButton!
    
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast = 1, chipmunk = 2, vader = 3, echo = 4, reverb = 5, normal = 6
    }

    #warning("Mark-up notations missing.")
//    MARK: playSoundForButton
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
           case .slow:
               playSound(rate: 0.5)
           case .fast:
               playSound(rate: 1.5)
           case .chipmunk:
               playSound(pitch: 1000)
           case .vader:
               playSound(pitch: -1000)
           case .echo:
               playSound(echo: true)
           case .reverb:
               playSound(reverb: true)
        case .normal:
             playSound(rate: nil, pitch: nil, echo: false, reverb: false)
           }

           configureUI(.playing)
    }

//    MARK: stopButtonPressed
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }

//    MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }

//    MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

}
