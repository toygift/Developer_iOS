//
//  ViewController.swift
//  Navigation
//
//  Created by jaeseong on 2017. 8. 4..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EditDelegate, UITextFieldDelegate {
    
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    
    var isOn = true
}


extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let editViewController = segue.destination as! EditViewController
        
        if segue.identifier == "editButton" {
            editViewController.textWayValue = "segue : 수정버튼 클릭"
            
        } else if segue.identifier == "editBarButton" {
            editViewController.textWayValue = "segue : 바 버튼 클릭"
            
        }
        
        editViewController.textMessages = txMessage.text!
        editViewController.isOn = isOn
        editViewController.delegate = self
        
    }
    
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        
        txMessage.text = message
    }
    
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        
        if isOn {
            imageView.image = imgOn
            self.isOn = true
        } else {
            imageView.image = imgOff
            self.isOn = false
        }
    }
}

extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = imgOn
        txMessage.delegate = self
        
    }
}
