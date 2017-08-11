//
//  ViewController.swift
//  Plist
//
//  Created by 이재성 on 2017. 6. 19..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle.main
        let path = bundle.path(forResource: "FriendList", ofType: "plist")
        
        if let realPath = path, let dic = NSDictionary(contentsOfFile: realPath) as? [String:AnyObject] {  //옵셔널 바인딩
            print(dic["list"]!)
            
        } else {
            //파일존재하지않음
        }
        
        //다음과 같이 변경가능함..
//        if let realPath = Bundle.main.path(forResource: "FriendList", ofType: "plist"),
//            let dic = NSDictionary(contentsOfFile: realPath) as? [String:AnyObject] {
//            print(dic["list"])
//            
//        } else {
//            //파일이 존재하지 않음.
//        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

