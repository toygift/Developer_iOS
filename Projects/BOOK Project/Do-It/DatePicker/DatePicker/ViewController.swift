//
//  ViewController.swift
//  DatePicker
//
//  Created by jaeseong on 2017. 8. 3..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var count = 0
    var alarmTime:String?
    

    @IBOutlet var currentTime:UILabel!
    @IBOutlet var selectedTime:UILabel!
    
    @IBAction func dataAndTime(_ sender:UIDatePicker) {
    
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        selectedTime.text = "선택시간 : " + formatter.string(from: datePickerView.date)
        
        formatter.dateFormat = "hh:mm aaa"
        alarmTime = formatter.string(from: datePickerView.date)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }
    
    func updateTime() {
//        currentTime.text = String(count)
//        count += 1
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        currentTime.text = "현재시간 : " + formatter.string(from: date as Date)
        
        formatter.dateFormat = "hh:mm aaa"
        let currentTimes = formatter.string(from: date as Date)
        
        if alarmTime == currentTimes {
            view.backgroundColor = UIColor.red
        } else {
            view.backgroundColor = UIColor.white
        }
        
    }
}

