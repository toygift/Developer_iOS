//
//  ViewController.swift
//  Audio
//
//  Created by jaeseong on 2017. 8. 7..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer: AVAudioPlayer!
    var audioFile: URL!
    let MAX_VOLUME: Float = 10.0
    var progressTimer: Timer!
    let timePlayerSelcetor: Selector = #selector(ViewController.updatePlayTime)
    
    @IBOutlet var progressPlay: UIProgressView!
    @IBOutlet var currentTime: UILabel!
    @IBOutlet var endTime: UILabel!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    @IBOutlet var volumeSlider: UISlider!


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
}

extension ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        initPlay()
        
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
}
