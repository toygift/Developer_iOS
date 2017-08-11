//
//  ViewController.swift
//  Scene-Trans02
//
//  Created by 이재성 on 2017. 6. 13..
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

    @IBAction func moveByNavi(_ sender: Any) {
        
        // 
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVc") else {
            return
        }
        self.navigationController?.pushViewController(uvc, animated: true)
    }
    @IBAction func movePresent(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVc") else {
            return
        }
        self.present(uvc, animated: true)
    }

}

