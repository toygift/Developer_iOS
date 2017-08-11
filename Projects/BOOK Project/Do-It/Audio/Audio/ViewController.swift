//
//  ViewController.swift
//  Audio
//
//  Created by jaeseong on 2017. 8. 7..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    var audioPlayer: AVAudioPlayer!
    var audioFile: URL!
    let MAX_VOLUME: Float = 10.0
    var progressTimer: Timer!
    let timePlayerSelcetor: Selector = #selector(ViewController.updatePlayTime)
    let timeRecordSelector: Selector = #selector(ViewController.updateRecordTime)
    var audioRecord: AVAudioRecorder!
    var isRecordMode = false
    
    
    @IBOutlet var progressPlay: UIProgressView!
    @IBOutlet var currentTime: UILabel!
    @IBOutlet var endTime: UILabel!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    @IBOutlet var volumeSlider: UISlider!

    @IBOutlet var recordButton: UIButton!
    @IBOutlet var recordTimeLabel: UILabel!
    
}

extension ViewController {
    
    @IBAction func playAudio(_ sender: UIButton) {
        
        audioPlayer.play()
        setPlayButton(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelcetor, userInfo: nil, repeats: true)
        
    }
    
    @IBAction func pauseAudio(_ sender: UIButton) {
        
        audioPlayer.pause()
        setPlayButton(true, pause: false, stop: true)
        
    }
    
    @IBAction func stopAudio(_ sender: UIButton) {
        
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        currentTime.text = convertNSTimeInterval2String(0)
        setPlayButton(true, pause: true, stop: false)
        progressTimer.invalidate()
        
    }
    
    @IBAction func volumeAudio(_ sender: UISlider) {
        
        audioPlayer.volume = volumeSlider.value
        
    }
    
    @IBAction func recordSwitch(_ sender: UISwitch) {
        
        if sender.isOn {
            
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            recordTimeLabel.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            recordButton.isEnabled = true
            recordTimeLabel.isEnabled = true
            
        } else {
            
            isRecordMode = false
            recordButton.isEnabled = false
            recordTimeLabel.isEnabled = false
            recordTimeLabel.text = convertNSTimeInterval2String(0)
            
        }
        
        selectAuioFile()
        
        if !isRecordMode {
            initPlay()
        } else {
            initRecord()
        }
    }
    
    @IBAction func recordButton(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Record" {
            audioRecord.record()
            sender.setTitle("Stop", for: UIControlState())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
        } else {
            audioRecord.stop()
            progressTimer.invalidate()
            sender.setTitle("Record", for: UIControlState())
            playButton.isEnabled = true
            initPlay()
        }
        
    }
}

extension ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectAuioFile()
        if !isRecordMode {
            initPlay()
            recordButton.isEnabled = false
            recordTimeLabel.isEnabled = false
        } else {
            initRecord()
        }
    }
}

extension ViewController {
    
    func initPlay() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        
        volumeSlider.maximumValue = MAX_VOLUME
        volumeSlider.value = 1.0
        
        progressPlay.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = volumeSlider.value
        endTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        currentTime.text = convertNSTimeInterval2String(0)
        

        setPlayButton(true, pause: false, stop: false)
        
    }
    
    func convertNSTimeInterval2String(_ time: TimeInterval) -> String {
        
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
        
    }
    
    func setPlayButton(_ play: Bool, pause: Bool, stop: Bool) {

        playButton.isEnabled = play
        pauseButton.isEnabled = pause
        stopButton.isEnabled = stop

    }
    
    func updatePlayTime() {
        
        currentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        progressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
        
    }
    
    func audioPlauerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        progressTimer.invalidate()
        setPlayButton(true, pause: false, stop: false)
        
    }
    
    func selectAuioFile() {
        if !isRecordMode {
            
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
            
        } else {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
            
        }
    }
    
    func initRecord() {
        
        let recordSettings = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey: 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0] as [String:Any]
        do {
            audioRecord = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        
        audioRecord.delegate = self
        audioRecord.isMeteringEnabled = true
        audioRecord.prepareToRecord()
        
        volumeSlider.value = 1.0
        audioPlayer.volume = volumeSlider.value
        endTime.text = convertNSTimeInterval2String(0)
        currentTime.text = convertNSTimeInterval2String(0)
        setPlayButton(false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("Error-setCategory : \(error)")
        }
        
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("Error-setActive : \(error)")
        }
    
    }
    
    func updateRecordTime() {
        recordTimeLabel.text = convertNSTimeInterval2String(audioRecord.currentTime)
    }
}
