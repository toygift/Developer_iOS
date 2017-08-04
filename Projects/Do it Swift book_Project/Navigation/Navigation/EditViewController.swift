//
//  EditViewController.swift
//  Navigation
//
//  Created by jaeseong on 2017. 8. 4..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit




class EditViewController: UIViewController {
    
    var textWayValue: String = ""
    var textMessages: String = ""
    var delegate: EditDelegate?
    
    var isOn = false
    
    @IBOutlet var switchOn: UISwitch!
    
    @IBOutlet var textMessage:UITextField!
    
    @IBOutlet var labelWay: UILabel!
    
    @IBAction func buttonDone(_ sender: UIButton) {
        
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: textMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchOnOff(_ sender: UISwitch) {
        
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
    }
    
}


extension EditViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelWay.text = textWayValue
        
        if textWayValue == "segue : 수정버튼 클릭"{
            labelWay.textColor = UIColor.red
        } else {
            labelWay.textColor = UIColor.blue
        }
        
        textMessage.text = textMessages
        switchOn.isOn = isOn

    }
}

