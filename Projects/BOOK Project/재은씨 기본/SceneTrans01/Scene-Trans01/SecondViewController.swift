//
//  SecondViewController.swift
//  Scene-Trans01
//
//  Created by 이재성 on 2017. 6. 13..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
