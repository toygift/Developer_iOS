//
//  ViewController.swift
//  UITest
//
//  Created by 이재성 on 2017. 6. 19..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var sliderLAbel: UILabel!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        self.sliderLAbel.text = String(sender.value)
    }
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        self.switchLabel.text = String(sender.isOn)
    }
    @IBAction func indicatorClicked(_ sender: UIButton) {
        
        if !sender.isSelected {
            self.activityIndicator.startAnimating()
            sender.isSelected = true
        } else {
            self.activityIndicator.stopAnimating()
            sender.isSelected = false
        }
        
    }
}

