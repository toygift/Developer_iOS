//
//  ViewController.swift
//  HelloWorld
//
//  Created by jaeseong on 2017. 8. 2..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var labelHello:UILabel!
    @IBOutlet var textName:UITextField!
    @IBAction func buttonSend(_ sender:UIButton) {
        
        labelHello.text = "Hello," + textName.text!
        
    }

}

