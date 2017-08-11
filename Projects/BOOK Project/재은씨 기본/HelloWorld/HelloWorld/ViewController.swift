//
//  ViewController.swift
//  HelloWorld
//
//  Created by jaeseong on 2017. 6. 7..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var uiTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sayHello(_ sender: Any) {
        self.uiTitle.text = "Hello , World"
    }

}

