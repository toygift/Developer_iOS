//
//  ViewController.swift
//  delegate
//
//  Created by jaeseong on 2017. 6. 12..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var inputText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputText.placeholder = "값을 입력하세요"
        self.inputText.keyboardAppearance = UIKeyboardAppearance.dark
        self.inputText.keyboardType = UIKeyboardType.alphabet
        self.inputText.returnKeyType = UIReturnKeyType.join
        self.inputText.enablesReturnKeyAutomatically = true
        
        /**
        스타일 설정
        */
        
        self.inputText.borderStyle = UITextBorderStyle.line
        self.inputText.backgroundColor = UIColor(white: 0.87, alpha: 1.0)
        self.inputText.contentVerticalAlignment = .center
        self.inputText.contentHorizontalAlignment = .center
        self.inputText.layer.borderColor = UIColor.darkGray.cgColor
        self.inputText.layer.borderWidth = 2.0
        
        //self.inputText.becomeFirstResponder()
        
        self.inputText.delegate = self
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func input(_ sender: Any) {
        //self.inputText.becomeFirstResponder()
        
    }
    @IBAction func confirm(_ sender: Any) {
        self.inputText.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("텍스트 필드 편집이 시작되었음")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 내용이 삭제됩니다")
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("텍스트 필드의 내용이 \(string)으로 변경됩니다")
        
        if Int(string) == nil {
            if (textField.text?.characters.count)! + string.characters.count > 10 {
                return false
            }else {
                return true
            }
        }else {
            return false
        }
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.becomeFirstResponder()
        print("텍스트 필드의 리턴키가 눌림")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 종료")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("텍스트 필드의 편집이 종료")
    }
}
