//
//  ViewController.swift
//  Bundle
//
//  Created by 이재성 on 2017. 6. 19..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path:[String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let basePath = path[0] + "/friendList.plist"
        
         //있는지 확인
        let fileManager = FileManager.default  //옵셔널 바인딩
        if !fileManager.fileExists(atPath: basePath) {
            if let bundlePath = Bundle.main.path(forResource: "FriendList", ofType: "plist") { //비어있을경우
                do  {
                    try fileManager.copyItem(atPath: bundlePath , toPath: basePath) //번들에 있는걸 베이스에 복사
                }catch {
                    return
                }
            }else { //비어있지 않은 경우
                return //리턴
            }
        }
        
        //받아오기
        let dic = NSDictionary(contentsOfFile: basePath) as? [String : AnyObject]
        
        let nsDic = NSDictionary(dictionary: dic!)
        nsDic.write(toFile: basePath, atomically: true)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

