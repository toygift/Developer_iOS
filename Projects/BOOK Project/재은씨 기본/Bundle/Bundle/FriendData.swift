//
//  FriendData.swift
//  Bundle
//
//  Created by 이재성 on 2017. 6. 19..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import Foundation


class FriendData {
    
    private static let instance:FriendData = FriendData()
    private var friendData:[String:Any]?
    
    
    //싱글톤 인스턴스
    class var standard:FriendData {
        return instance
    }
    
    //읽어오기
    //dictionary로 되어있는 plist를 불러와서 realPath에 대입
    //path[0]은 .plist파일의 경로
    //path불러올때 NSSearchPathForDirectoriesInDomains 사용
    private func load() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let realPath = path[0] + "/FriendList.plist"
        //friendData에 dictionary 경로 넣음(다운캐스팅)
        friendData = NSDictionary(contentsOfFile: realPath) as? [String:Any]
    }
    
    
    
    //저장하기
    private func save() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let realPath = path[0] + "/FriendList.plist"
        
        let fileManager = FileManager.default
        /*open class FileManager : NSObject {
         Returns the default singleton instance.
         open class var `default`: FileManager { get } */
        
        //없는경우 번들에 있는 파일 document에 복사
        if !fileManager.fileExists(atPath: realPath) {
            if let bundlePath = Bundle.main.path(forResource: "FriendList", ofType: "plist") {
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: realPath)
                } catch {
                    print("none")
                    return
                }
            }
            print("데이터없음")
            return
        }
        
        //쓰기
        //dict 에 dictionary 경로 넣음
        //loadData에 경로 넣고 loadData update함\
        //document 폴더에 있는 파일을 NSDictionary을 통해서 Dictionary인스턴스로 불러오기
        
        if let dict = NSDictionary(contentsOfFile: realPath) as? [String:Any] {
            //dictionary를 수정
            //NSDictionary로 변경후 writeTofile 메소드를 통해 파일에 저장
            var loadData = dict
            loadData.updateValue("addData", forKey: "key")
            //nsDic을 NSDictionary 타입으로 지정하고 nsDic에 파일경로 집어넣음
            let nsDic:NSDictionary = NSDictionary(dictionary: loadData)
            nsDic.write(toFile: realPath, atomically: true)
        }
    }
    
    
    func object(forkey defaultName:String) -> Any? {
        guard let data = friendData else {
            return nil
        }
        return data[defaultName]
    }
    
    func set(_ value:Any?, forkey defaultName:String) {
        guard let _ = friendData, let valueData = value else {
            return
        }
        friendData![defaultName] = valueData
    }
    
    func removeObject(forkey defaultName:String) {
        guard let _ = friendData else {
            return
        }
        friendData!.removeValue(forKey: defaultName)
        
    }
    
    func friendDataSave() {
        save()
    }
    
    private init(){
        load()
    }
    
    deinit {
        save()
    }
}





