//
//  ViewController.swift
//  AloneStudy#3
//
//  Created by jaeseong on 2017. 5. 24..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {



        override func viewDidLoad() {
        super.viewDidLoad()
            /*var optInt : Int?
             optInt = 3
             
             var optStr : String?
             optStr = "swift"
             
             var optDouble : Double?
             var optArr : [String]?
             optArr = ["C", "java", "Object-c", "smalltalk"]
             
             var optDic : Dictionary<String, String>?
             optDic = ["국어" : 94, "수학" : 88, "영어" : 96]
             
             
             var optDic2 : [String:String]?
             
             var optClass : AnyObject?*/
            
        var optInt : Int? = 3
        
        print("옵셔널 자체의 값 : \(optInt)")
        print("!로 강제 해제한 값 : \(optInt!)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

