//
//  DataCentre.swift
//  TelegramCell
//
//  Created by jaeseong Lee on 2017. 7. 13..
//  Copyright © 2017년 jaeseong Lee. All rights reserved.
//

import Foundation


class DataCentre {
    
    static let shered: DataCentre = DataCentre() //싱글톤인스턴스생성
    
    private var cellArray: [Telegram] = [] //[Telegram] Type Array 생성, 외부에서 접근하면 안됨 why? 내생각에 제일 중요한 변수(모든데이터 담는 Array)
    
    
    var cellData: [Telegram] { // 연산프로퍼티 외부에서 접근 가능하게..
        get {
            return cellArray
        }
    }
    private init() { //init시에 plist파일 가지고 와서 초기화(retuen에서)함.. 이것도 외부에 노출되면 안되므로 private
        let bundlePath: String = Bundle.main.path(forResource: "telegram", ofType: "plist")! //번들에 있는 파일주소 가지고 옴.
        if let loadedArray = NSArray(contentsOfFile: bundlePath) as? [[String:String]] { //closure
            self.cellArray = loadedArray.map({ (dictionary: [String:String]) -> Telegram in  //.map으로 plist데이터로 cellArray 초기화
                return Telegram.init(withDic: dictionary)                                    // for문으로 돌려서 해도 됨 .map 에 대해 확실히 공부하기
            })
        }
    }
}

struct Telegram {
    let image:String
    let name:String
    let comment:String
    
    
    init(withDic: [String:String]){ //plist의 키값에 매칭되는 value값을 넣어줌
        self.name = withDic["user_name"]!
        self.comment = withDic["user_comment"]!
        self.image = withDic["user_image"]!
    }
}
