//
//  DataCenter.swift
//  NagMaker
//
//  Created by HyunJomi on 2017. 7. 6..
//  Copyright © 2017년 HyunJung. All rights reserved.
//

import UIKit

class DataCenter{
    
    static let standard = DataCenter()
    
    var nagArray: [NagData] = [] // 각 location 정보와 그에 속한 잔소리 정보를 담는 배열 
    
    private let fileManager:FileManager = FileManager()
    
    private let docPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! + "/NagData.plist"
    
    private init() {
        
        if fileManager.fileExists(atPath: docPath) {
            self.loadFromDoc()
        } else {
            self.loadFromBundle()
        }
        
    }
    
    private func loadFromBundle() {
        let bundlePath: String = Bundle.main.path(forResource: "NagData", ofType: "plist")!
        if let loadedArray = NSArray.init(contentsOfFile: bundlePath) as? [[String:Any]] {
            for i in loadedArray{
                nagArray.append(NagData(with: i))
            }
        
        }
        try? fileManager.copyItem(atPath: bundlePath, toPath: docPath)
    }
    
    private func loadFromDoc() {
        if let loadedArray = NSArray.init(contentsOfFile: docPath) as? [[String:Any]] {
            for i in loadedArray{
                
                nagArray.append(NagData(with: i))
            }
        }
    }
    
    func forcelySave() {
        
        saveToDoc()
    }

    private func saveToDoc() {
        
        let nsArray: NSArray = NSArray.init(array: self.nagArray.map({ (data: NagData) -> [String:Any] in
            return data.dictionary
        }))
        
        nsArray.write(toFile: docPath, atomically: true)
    }
    
    // 2017.07.11 업데이트 (정교윤)
    // 메인 화면에서 선택한 collection view의 item을 기준으로 데이터 추가
    func addNag(_ dict:[String:Any], selectedLocation:Int) {
        
        self.nagArray[selectedLocation].nagList.append(Nag(with: dict))
        
        self.saveToDoc()
    }
    
    // 2017.07.11 업데이트 (정교윤)
    // 메인 화면에서 선택한 collection view의 item을 기준으로 수정하고자 하는 NAG ID를 파라메터로 전달해서 데이터 수정
    func editNag(_ dict:[String:Any], selectedLocation:Int, editNagID:Int) {
        
        var nagListindex:Int = 0
        
        for nag in self.nagArray[selectedLocation].nagList {
            
            if nag.nagID == editNagID {
                break
            }
    
            nagListindex += 1
            
        }
        
        self.nagArray[selectedLocation].nagList[nagListindex] = Nag(with: dict)
        
        self.saveToDoc()
        
    }
    
    // 2017.07.11 업데이트 (정교윤)
    // 메인 화면에서 선택한 collection view의 item을 기준으로 삭제하고자 하는 NAG ID를 파라메터로 전달해서 데이터 삭제
    func removeNag(selectedLocation:Int, removeNagID:Int) {
        
        var nagListindex:Int = 0
        
        for nag in self.nagArray[selectedLocation].nagList {
            
            
            
            if nag.nagID == removeNagID {
                break
            }
            
            nagListindex += 1
            
        }
        
        self.nagArray[selectedLocation].nagList.remove(at: nagListindex)
        
        self.saveToDoc()
    }
    
    // 2017.07.10 업데이트 (정교윤)
    // 현재 존재하는 Nag Item의 총 개수를 리턴 => 새로운 ID로 사용
    func getTotalCountOfExistingNagItems() -> Int {
        
        var count: Int = 0
        
        for nag in self.nagArray {
            
            count += nag.nagList.count
            
            
        }
        
        return count
        
    }


    
}
