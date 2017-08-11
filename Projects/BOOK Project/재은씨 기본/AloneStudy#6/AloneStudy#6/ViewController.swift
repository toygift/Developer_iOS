//
//  ViewController.swift
//  AloneStudy#6
//
//  Created by jaeseong on 2017. 5. 30..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var optInt : Int?
//        optInt = 3
//        print(optInt)
//        
//        var optStr: String?
//        optStr = "Swifr"
//        print(optStr)
//        
//        var optArr : [String]?
//        optArr = ["c", "java", "objective-c","smalltalk"]
//        print(optArr)
        
//        var optInt : Int? = 3
//        print("옵셔널 자체의 값 \(optInt)")
//        print("옵셔널 강제 해제의 값 \(optInt!)")
        
        var str = "Swift"
        
        if let intFromStr = Int(str){
            print("반환된 값은\(intFromStr)입니다")
        }else {
            print("값 반환에 실패")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

