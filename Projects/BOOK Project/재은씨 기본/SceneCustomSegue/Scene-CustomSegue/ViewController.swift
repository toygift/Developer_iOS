//
//  ViewController.swift
//  Scene-CustomSegue
//
//  Created by 이재성 on 2017. 6. 14..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "custom_segue") {
            NSLog("커스텀세그 실행")
        }else if (segue.identifier == "action_segue"){
            NSLog("액션세그 실행")
        }else {
            NSLog("알수없는 세그 실행")
        }
        
    }
}

