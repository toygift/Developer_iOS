//
//  TimerViewController.swift
//  NagMaker
//
//  Created by 윤새결 on 2017. 7. 6..
//  Copyright © 2017년 HyunJung. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import UIView_Shake

class TimerViewController: UIViewController {
    
    
    private var timer: Timer?
    private var isPlay: Bool = true
    
    
    var locationIndex:Int! // collection view 인덱스 
    
    var nagID: Int?
    var nagData: Nag?
    var duration: Int?
    let synthesizer = AVSpeechSynthesizer()
    var tempIndex: Int = 0 // 타이머가 중단된 시점
    
    var resumeTimer:Bool = false // 사용자가 다시 타이머를 킬 경우 재시작하기 위해 필요한 변수 (2017.7.13 추가 - 정교윤)

    
    deinit {
        self.timer?.invalidate()
    }
    
    //MARK:- outlet
    
    @IBOutlet weak var nagTitleLable: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playAndPauseButton: UIButton! // 2017.07.13 추가 (정교윤)
    
    
    //MARK:- IBACtion
    
    @IBAction func touchedTimerButton(_ sender: UIButton) {
        
        if self.isPlay == true {
            
            sender.setImage(UIImage.init(named: "play.png"), for: .normal)
            self.isPlay = false
            self.timer?.invalidate()
            self.synthesizer.pauseSpeaking(at: .word)
        } else {
            
            sender.setImage(UIImage.init(named: "pause.png"), for: .normal)
            self.isPlay = true // 추가
            
            if self.resumeTimer == false { // 중간에 재시작하는 경우 - - 2017.07.13 업데이트 (정교윤)
                
                self.timer?.fire(startTimer(index: tempIndex))
                let utterance = AVSpeechUtterance(string: (nagData?.nagTitle)!)
                self.synthesizer.speak(utterance)
                
                
            } else { // 반복구간을 다 채우고 버튼을 누른 경우 - 2017.07.13 업데이트 (정교윤)
                
                self.startTimer(index: self.duration!)
                self.resumeTimer = false
                
            }
            
            
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startTimer(index: self.duration!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nag = self.nagData?.nagTitle
        self.duration = nagData?.duration
        self.nagTitleLable.text = nag
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
        self.synthesizer.stopSpeaking(at: .immediate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer(index: Int) {
        var realIndex = index
        let nag = self.nagData?.nagTitle
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [unowned self] (timer: Timer) -> Void in
            
            let formatter = DateFormatter()
            formatter.dateFormat = "mm:ss"
            
            self.timerLabel.text = String(realIndex)
            
            let utterance = AVSpeechUtterance(string: nag!)
            utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
            utterance.rate = 0.48
            self.synthesizer.speak(utterance)
            
            
            realIndex -= 1
            
            self.tempIndex = realIndex
            
            if realIndex == 5 {
                self.view.shake(400, withDelta: 5.0, speed: 0.03, shakeDirection: ShakeDirection.vertical)
            }
            if realIndex == 0 {
                
                self.synthesizer.stopSpeaking(at: AVSpeechBoundary.word)
                self.timer?.invalidate()
                
                let afterNagY = self.nagData?.nagAnswerY
                let afterNagN = self.nagData?.nagAnswerN
                
                let alert: UIAlertController = UIAlertController(title: "다했니?", message: "검사한다?", preferredStyle: .alert)
                let alertActionYes: UIAlertAction = UIAlertAction(title: "다했어요", style: .default, handler: { [unowned self] (action: UIAlertAction) -> Void in
                    let utteranceYes = AVSpeechUtterance(string: afterNagY!)
                    utteranceYes.voice = AVSpeechSynthesisVoice(language: "ko-KR")
                    utteranceYes.rate = 0.4
                    self.synthesizer.speak(utteranceYes)
                    
                })
                
                let alertActionNo: UIAlertAction = UIAlertAction(title: "아니요", style: .default, handler: { [unowned self] (action: UIAlertAction) -> Void in
                    let utteranceNo = AVSpeechUtterance(string: afterNagN!)
                    utteranceNo.voice = AVSpeechSynthesisVoice(language: "ko-KR")
                    utteranceNo.rate = 0.4
                    self.synthesizer.speak(utteranceNo)
                })
                
                alert.addAction(alertActionYes)
                alert.addAction(alertActionNo)
                
                // 2017.07.12 completion closure 추가 (정교윤)
                // 타이머와 관련하여 Stop sound in AVAudioPlayer and shown AQDefaultDevice (173): skipping input stream Error Logs
                // 가 보이면서 계속 백그라운드로 어떤 프로세스가 실행되고 있는 문제점이 있었는데 
                // 아래와 같은 방법으로 해결함 => xcode 8 버전에 버그가 있어서 따로 설정을 해야 함
                // Select Product --> Scheme--> Edit Scheme.
                // Select Arguments.
                // Add OS_ACTIVITY_MODE setup "disable" to Environment Variables.
                self.present(alert, animated: true, completion: {
                    
                    self.timer = nil // 이 코드를 넣지 않을 경우 타이머가 제대로 종료되지 않고 -1, -2 로 숫자가 바뀌며 계속 실행된다.
                    self.playAndPauseButton.setImage(UIImage.init(named: "play.png"), for: .normal)
                    self.resumeTimer = true
                    self.isPlay = false
                    self.tempIndex = 0
                    
                })
                
                self.timerLabel.text = String(0)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let addVC: AddAndEditViewController = segue.destination as! AddAndEditViewController
        
        addVC.locationIndex = self.locationIndex
        
        addVC.nagID = self.nagID
        
        addVC.editedItem = self.nagData
        
        addVC.totalSeconds = self.nagData?.duration
        
        addVC.isEditMode = true
        
       
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
