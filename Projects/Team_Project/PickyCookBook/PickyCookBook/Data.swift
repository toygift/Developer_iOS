//
//  Data.swift
//  PickyCookBook
//
//  Created by jaeseong on 2017. 8. 3..
//  Copyright © 2017년 유하늘. All rights reserved.
//

import Foundation

class Data {
    static var shared: Data = Data()
    
    var userArray: [User] = []
    var user: User?
    
}




struct User {
    
    var email: String?
    var password: String?
    var nickName: String?
    
    
    init(email: String, password: String, nickName: String){
        
        self.email = email
        self.password = password
        self.nickName = nickName
        
    }
//    var dic:[String:Any] {
//        return
//        //데이터 오는형태로 리턴
//    }
}
