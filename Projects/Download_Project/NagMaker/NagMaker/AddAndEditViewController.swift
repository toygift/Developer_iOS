//
//  AddAndEditViewController.swift
//  NagMaker
//
//  Created by 정교윤 on 2017. 7. 6..
//  Copyright © 2017년 HyunJung. All rights reserved.
//

import UIKit

class AddAndEditViewController: UIViewController {
    
    
    var locationIndex: Int! // 선택한 로케이션의 인덱스
    var nagID: Int? // 잔소리 아이디
    
    @IBOutlet weak var nagOne: UITextField!// 잔소리 필드
    @IBOutlet weak var nagTwo: UITextField!// 잔소리를 하고 대상자가 말을 들었을 때 할 말을 입력할 필드
    @IBOutlet weak var nagThree: UITextField!// 잔소리를 하고 대상자가 말을 안 들었을 때 할 말을 입력할 필드
    
    @IBOutlet weak var deleteButton: UIButton! // 삭제 버튼
    @IBOutlet weak var minutesTF: UITextField! // 분 필드
    @IBOutlet weak var secondsTF: UITextField! // 초 필드
    @IBOutlet weak var titleLabel: UILabel!
    
    var isEditMode:Bool = true // 현재 화면이 수정하기 화면인지 추가하기 화면인지 결정하는 변수
    
    var minutesArray:[String] = [""] // 사용자가 선택할 반복구간과 관련하여 분이 저장될 배열
    var secondsArray:[String] = [""] // 사용자가 선택할 반복구간과 관련하여 초가 저장될 배열
    
    var minutes:Int? // 분
    var seconds:Int? // 초
    var totalSeconds:Int?  // 분과 초로 표현된 수를 초로 환산
    
    var editedItem:Nag? // 수정할 아이템 (잔소리 정보)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Editing Mode: \(isEditMode)")
        
        makeMinutesArray()
        makeSecondsArray()
        
        self.deleteButton.layer.borderColor = UIColor.lightGray.cgColor
        self.deleteButton.layer.borderWidth = 1
        self.deleteButton.layer.cornerRadius = 5
        
        if isEditMode == true { // 수정하기 화면 셋팅
            self.title = "수정하기"
            self.titleLabel.text = "EDIT NAG"
            self.deleteButton.isHidden = false
        } else { // 추가하기 화면으로 셋팅
            self.title = "추가하기"
            self.titleLabel.text = "ADD NAG"
            self.deleteButton.isHidden = true
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if self.isEditMode == true {
            
            convertToMinutesSeconds()
            
            if let item = editedItem {
                
                self.nagID = item.nagID
                self.nagOne.text = item.nagTitle
                self.nagTwo.text = item.nagAnswerY
                self.nagThree.text = item.nagAnswerN
                
                
                self.minutesTF.loadDropdownDataEditMode(data: minutesArray, text: String(self.minutes!))
                self.secondsTF.loadDropdownDataEditMode(data: secondsArray, text: String(self.seconds!))
                
                self.totalSeconds = convertToSeconds(self.minutes!, self.seconds!)
                
            }
            
            
        } else {
            
            self.nagOne.text = ""
            self.nagTwo.text = ""
            self.nagThree.text = ""
            
            
            self.minutesTF.loadDropdownData(data: minutesArray)
            self.secondsTF.loadDropdownData(data: secondsArray)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 입력 필드 외에 다른 화면 터치했을 때 키보드 내려가게 만드는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    /// 분 배열 만드는 함수
    func makeMinutesArray() {
        for i in 0...59 {
            minutesArray.append(String(i))
        }
    }
    
    /// 초 배열 만드는 함수
    func makeSecondsArray() {
        for i in 0...59 {
            secondsArray.append(String(i))
        }
    }
    
    @IBAction func saveButtonTouched(_ sender: UIBarButtonItem) {
    
    
        if self.nagOne.text == "" || self.nagTwo.text == "" || self.nagThree.text == "" || self.minutesTF.text == "" || self.secondsTF.text == "" {
    
            presentAlertWithTitleFail(title: "입력 에러", message: "모든 입력란에 값을 입력하여 주세요!")
    
        } else {
    
            if self.minutesTF.text == "0" && self.secondsTF.text == "0" {
                    presentAlertWithTitleFail(title: "입력 에러", message: "0분 0초는 입력하실 수 없습니다!")
            } else {
                presentAlertWithTitleSuccessSave(title: "입력값 체크완료", message : "이대로 저장하시겠습니까?")
            }
    
    
        }
    
    }
    
    
    @IBAction func deleteButtonTouched(_ sender: UIButton) {
    
        presentAlertWithTitleSuccessDelete(title: "데이터 삭제 확인 메시지", message : "이대로 삭제하시겠습니까?")
    
    }
    
    /// Save 버튼 눌렀을 때 나오는 알럿 메시지 출력하는 함수 => 새로운 데이터 추가 또는 기존 데이터 수정
    func presentAlertWithTitleSuccessSave(title: String, message : String)
    {
        
        
        // 기존 데이터를 수정할 때
        if self.isEditMode == true {
            
            print(Int(self.minutesTF.text!)!)
            print(Int(self.secondsTF.text!)!)
            
            self.totalSeconds = convertToSeconds(Int(self.minutesTF.text!)!, Int(self.secondsTF.text!)!)
            
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction) in
            DataCenter.standard.editNag(["nag_id":self.nagID!,"nag_title":self.nagOne.text!,"nag_answer_Y":self.nagTwo.text!,"nag_answer_N":self.nagThree.text!,"duration":self.totalSeconds!], selectedLocation: self.locationIndex!, editNagID: self.nagID!)
                
                // 2017.07.11 코드 업데이트 (정교윤)
                // Navigation Controller에 바로 연결된 root 화면으로 이동시키는 부분
                //self.navigationController?.popViewController(animated: true) => 이전 화면으로 이동시키면 리프레쉬가 되지 않은 화면이
                // 나오는 관계로 아래의 코드로 대체함
                self.navigationController?.popToRootViewController(animated: true)
                
            }
            
            let CANCELAction = UIAlertAction(title: "CANCEL", style: .default) {
                (action: UIAlertAction) in print("CANCEL EDIT")//returnMsg = false //self.moveToMainNagMaker = false
            }
            
            alertController.addAction(OKAction)
            alertController.addAction(CANCELAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else { // 새로 아이템을 추가할 때
            
            
            print(Int(self.minutesTF.text!)!)
            print(Int(self.secondsTF.text!)!)
            
            self.totalSeconds = convertToSeconds(Int(self.minutesTF.text!)!, Int(self.secondsTF.text!)!)
            
            
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction) in
                
                print("ADD ADD PART")
                // 새로운 인덱스를 UserDefaults에 저장한다.
                
                let newNagID = UserDefaults.standard.integer(forKey: "NewItemIndex")
                
            DataCenter.standard.addNag(["nag_id":newNagID,"nag_title":self.nagOne.text!,"nag_answer_Y":self.nagTwo.text!,"nag_answer_N":self.nagThree.text!,"duration":self.totalSeconds!], selectedLocation: self.locationIndex)
                
                
                // 2017.07.11 코드 업데이트 (정교윤)
                // Navigation Controller에 바로 연결된 root 화면으로 이동시키는 부분
                //self.navigationController?.popViewController(animated: true) => 이전 화면으로 이동시키면 리프레쉬가 되지 않은 화면이
                // 나오는 관계로 아래의 코드로 대체함
                self.navigationController?.popToRootViewController(animated: true)
                
                
            }
            
            let CANCELAction = UIAlertAction(title: "CANCEL", style: .default) {
                (action: UIAlertAction) in print("CANCEL ADD")//returnMsg = false//self.moveToMainNagMaker = false
            }
            
            alertController.addAction(OKAction)
            alertController.addAction(CANCELAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        
        
        
    }
    
    /// 삭제 버튼 눌렀을 때
    func presentAlertWithTitleSuccessDelete(title: String, message : String) {
        
        if self.isEditMode == true {
            
            print(Int(self.minutesTF.text!)!)
            print(Int(self.secondsTF.text!)!)
            
            self.totalSeconds = convertToSeconds(Int(self.minutesTF.text!)!, Int(self.secondsTF.text!)!)
            
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction) in
                
                DataCenter.standard.removeNag(selectedLocation: self.locationIndex!, removeNagID: self.nagID!)
                
                // 2017.07.11 코드 업데이트 (정교윤)
                // Navigation Controller에 바로 연결된 root 화면으로 이동시키는 부분
                //self.navigationController?.popViewController(animated: true) => 이전 화면으로 이동시키면 리프레쉬가 되지 않은 화면이
                // 나오는 관계로 아래의 코드로 대체함
                self.navigationController?.popToRootViewController(animated: true)
                
                
            }
            
            let CANCELAction = UIAlertAction(title: "CANCEL", style: .default) {
                (action: UIAlertAction) in print("CANCEL DELETE") //self.moveToMainNagMaker = false
            }
            
            alertController.addAction(OKAction)
            alertController.addAction(CANCELAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    /// 입력값을 넣지 않아 alert 창 띄울 때 사용되는 함수
    func presentAlertWithTitleFail(title: String, message : String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in print("FAIL") //self.moveToMainNagMaker = false
        }
        
        
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // 초단위로 저장된 데이터를 분과 초로 환산하여 화면에 보여주는 함수
    func convertToMinutesSeconds() {
        
        self.minutes = (self.totalSeconds! % 3600) / 60
        self.seconds = (self.totalSeconds! % 3600) % 60
        
    }
    
    // 분과 초로 표시된 두 개의 숫자를 합쳐서 초로 환산하는 함수
    func convertToSeconds(_ minutes:Int, _ seconds:Int) -> Int {
        
        let totalSeconds = (minutes * 60) + seconds
        
        return totalSeconds
        
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
