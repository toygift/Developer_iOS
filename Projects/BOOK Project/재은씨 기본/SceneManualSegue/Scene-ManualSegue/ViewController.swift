//
//  ViewController.swift
//  Scene-ManualSegue
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

    @IBAction func wind(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualSegue", sender: self)
    }

}

