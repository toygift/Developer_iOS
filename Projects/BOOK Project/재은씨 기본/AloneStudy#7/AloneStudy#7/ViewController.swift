//
//  ViewController.swift
//  AloneStudy#7
//
//  Created by jaeseong on 2017. 5. 31..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let uInfo = getIndvInfo()
//        uInfo.h
//        uInfo.g
//        uInfo.n
//
//        printHello(to: "이재성", welcomeMessage: "안녕하세요")
//        printHell(to: "이재성", "안녕하세요")
        
//        print(avg(score: 10,20,30,40,50))
//        echo(message: "이재성")
//        echo(message: "이재성", newline: false)
//        print(descAge(name: "이재성", paramAge: 36))
        var count = 30
        print(foo(paramCount: &count))
        print(count)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    typealias infoResult = (h: Int, g: Character, n: String)
    
//    func getIndvInfo() -> infoResult{
//        let height = 180
//        let name = "꼼꼼한 재성씨"
//        let gender : Character = "M"
//        
//        return (height, gender, name)
//    }
//    
//        func printHello(to name: String, welcomeMessage msg: String){
//            print("\(name)님, \(msg)")
//        }
//        func printHell(to name: String, _ msg: String){
//            print("\(name)님, \(msg)")
//    }
//    func avg(score : Int...) -> Double {
//        var total = 0
//        for r in score{
//            total += r
//        }
//        return (Double(total) / Double(score.count))
//    }
//    func echo(message : String, newline : Bool = true){
//        if newline == true {
//            print(message, true)
//        } else {
//            print(message, false)
//        }
//    }
//    func descAge(name: String, paramAge : Int) -> String{
//        var reName = name
//        var reParamAge = paramAge
//        
//        reName = name + "씨"
//        reParamAge += 1
//        
//        return "\(reName)의 내년 나이는 \(reParamAge)세 입니다"
//    }
    func foo(paramCount:inout Int) -> Int{
        paramCount += 1
        return paramCount
    }
}
