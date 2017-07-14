//
//  ViewController.swift
//  SeguePracticeForSwift
//
//  Created by 박종찬 on 2017. 5. 30..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentIndicatorLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        self.segmentIndicatorLabel.text = "세그먼트가 \(sender.titleForSegment(at: sender.selectedSegmentIndex)!)번으로 변경되었습니다."
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if segmentedControl.selectedSegmentIndex == 0 {
            return true
        } else {
            return false
        }
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
}

