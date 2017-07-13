//
//  DataCenter.swift
//  DataCenterPractice
//
//  Created by 박종찬 on 2017. 6. 30..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

import UIKit

typealias dicStringAny = [String:Any]

class DataCenter {
    
    static let shared: DataCenter = DataCenter.init()

    private var rawArray: [Person]!
    
    var dataArray: [Person] {
        get {
            return rawArray
        }
    }
    
    private let fileManager:FileManager = FileManager()
    //documentPath
    private let documentPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! + "/Person.plist"
    
    
    private init() {
        if fileManager.fileExists(atPath: documentPath) {
            loadFromDoc()//파일매니저에 파일이 존재하는경우 도큐먼트 로드
        } else {
            loadFromBundle()//파일매니저에 파일이 존재하지 않는 경우 번들에서 복사
        }
    }
    //파일매니저에 파일이 존재하는 경우
    private func loadFromDoc() {
        if let loadedArray = NSArray.init(contentsOfFile: documentPath) as? [dicStringAny] {
            parsePersons(loadedArray)
        }
    }
    //파일매니저에 파일이 존재하지 않는 경우
    private func loadFromBundle() {
        let bundlePath: String = Bundle.main.path(forResource: "Person", ofType: "plist")!
        if let loadedArray = NSArray.init(contentsOfFile: bundlePath) as? [dicStringAny] {
            parsePersons(loadedArray)
        }
        try? fileManager.copyItem(atPath: bundlePath, toPath: documentPath)
        print(self.rawArray)
    }
    
    
    private func parsePersons(_ array: [dicStringAny]) {
        self.rawArray = array.map({ (dictionary: dicStringAny) -> Person in
            return Person.init(with: dictionary)
        })
    }
    
    private func saveToDoc() {
        let nsArray: NSArray = NSArray.init(array: self.rawArray.map({ (person: Person) -> dicStringAny in
            return person.dictionary
        }))
        nsArray.write(toFile: documentPath, atomically: true)
    }
    
    func addPerson(_ dict:dicStringAny) {
        self.rawArray.append(Person.init(with: dict))
        self.saveToDoc()
    }
    
    
}
