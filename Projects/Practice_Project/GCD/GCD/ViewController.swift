//
//  ViewController.swift
//  GCD
//
//  Created by jaeseong on 2017. 7. 14..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        //thread 만들어서 사용
        /********비동기방식***********/
        let queue1 = DispatchQueue(label: "com.toygift.GCD.queue1")
        queue1.async { //비동기
            for n in 1..<100 {
                print(n)
            }
        }
        
        queue1.async { //비동기
            for n in 100...200 {
                print(n)
            }
        }
        
        /*********동기방식************/
        let queue2 = DispatchQueue(label: "com.toygift.GCD.queue2", qos: .userInteractive)
        queue2.sync { //동기
            for n in 1000...1100 {
                print(n)
            }
        }
        
        
        /********비동기방식***********/
        let queue3 = DispatchQueue(label: "com.toygift.GCD.queue3", qos: .background, attributes: .concurrent)
        queue3.async {
            for n in 1...10 {
                print(n)
            }
        }
        queue3.async {
            for n in 6000...6100 {
                print(n)
            }
            
            DispatchQueue.main.async {
                self.label.text = "End"
            }
            //self.label.text = "End"
            
        }
        
        let queue4 = DispatchQueue(label: "com.toygift.GCD.queue4", qos: .background, attributes: [.initiallyInactive, .concurrent])
        
        let workItem = DispatchWorkItem {
            print("workItem")
        }
        queue4.async(execute: workItem)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

