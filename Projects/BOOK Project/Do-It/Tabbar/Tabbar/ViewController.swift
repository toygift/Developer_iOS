//
//  ViewController.swift
//  Tabbar
//
//  Created by jaeseong on 2017. 8. 4..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func moveImage(_ sender:UIButton) {
        tabBarController?.selectedIndex = 1
    }

    @IBAction func movePicker(_ sender:UIButton) {
        tabBarController?.selectedIndex = 2
    }


}

