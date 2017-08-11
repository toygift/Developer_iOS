//
//  ViewController.swift
//  Alonestudy#2
//
//  Created by jaeseong on 2017. 5. 22..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var cities = ["seoul", "new york", "la", "santiago"]
//        //let length = cities.count
//        
//        for i in cities {
//            let index = cities.index(of: i)
//            print("배열 원소는 \(i)입니다")
//        }
        
//        var cities = Array<String>()
//        var cities : Array<String>
//        cities = Array()
//        cities = Array<String>()
//        
//        var cities = [String]()
//        var cities : [String]
//        cities = []
//        cities = [String]()
//        

//        var list:Array = [String]()
//        
//        if list.isEmpty {
//            print("배열이 비어있는 상태")
//        } else {
//            print("배열에는 \(list.count)개의 아이템이 지정되어있음")
//        }
//        
        
//
//        var cities = [String]()
//        
//        cities.append("Seoul")
//        cities.append("New York")
//        cities.insert("Tokyo", at: 1)
//        cities.append(contentsOf: ["Dubai","Sydney"])
//        print(cities)
//        
//        cities[2] = "Mardrid"
//        print(cities)
        
        
//        var genres : Set = ["Classic", "Rock", "Balad"]
//        var g : Set<String> = []
//        var genres : Set<String> = ["Classic", "Rock", "Balad"]
//        
//        var genres = Set<String>()
//        genres.insert("Classic")
//        genres.insert("Rock")
//        genres.insert("Balad")
//        
//        if genres.isEmpty {
//            print("집합이 비어있습니다")
//        }else {
//            print("집합에는 현재 \(genres.count)개의 아이템이 저장되어 있습니다")
//        }
//        
        
//
//        var genres : Set = ["Classic", "Rock", "Balad"]
////        for g in genres.sorted(){
////            print("\(g)")
////        }
//        
//        genres.insert("Jazz")
//        genres.insert("Rock")
//        genres.insert("Rock")
//        
//        print(genres)
//        
//        if let removedItem = genres.remove("Rock") {
//            print("아이템 \(removedItem)이 삭제되었습니다")
//        }else {
//            print("삭제할 값이 집합에 추가되어 있지 않습니다")
//        }
//
//        
//        A = Array(Set(A))
//        
//        
//        let tupleValue = ("a", "b", 1, 2.5, true)
//        
//        print(tupleValue.0)
//        print(tupleValue.1)
//        print(tupleValue.2)
//        print(tupleValue.3)
//        print(tupleValue.4)

//        var tp101 : (Int, Int) = (100, 200)
//        var tp102 : (Int, String, Int) = (100, "a", 200)
//        var tp103 : (Int, (String, String)) = (100, ("a", "b"))
//        var tp104 : (String) = ("sample string")
//        
//        print(tp101,tp102,tp103,tp104)
//        
//        
//        
//
//        let tupleValue : (String, Character, Int, Float, Bool) = ("a", "b", 1, 2.3, true)
//        
//        let (a,b,c,d,e) = tupleValue
//        
//        print(a, b, c, d, e)
//        
//        
        
//        var capital = ["KR":"Seoul", "EN":"Londeon", "FR":"Paris"]
//        capital["KR"]

        var capital = [String : String]()
        capital["JP"] = "Tyoko"

        capital.updateValue("Seoul", forKey: "KR")
        capital.updateValue("London", forKey: "EN")
        capital.updateValue("sapporo", forKey: "JP")
        
        //print(capital)
        
        capital.updateValue("ottawa", forKey: "CA")
        capital.updateValue(("Beijing"), forKey: "CN")
        
//        print(capital)
//        
//        capital["CN"] = nil
//        
//        print(capital)
//        
//        capital.removeValue(forKey: "CA")
//        print(capital)
        
//        if let removedValue = capital.removeValue(forKey: "CA") {
//            print("삭제된 값은 \(removedValue)입니다")
//        }else {
//            print("아무것도 삭제 되지 않았습니다")
//        }
//        
//        
        for (key, value) in capital {
            //let (key, value) = row
            print("현재 데이터는 \(key) : \(value)  입니다")
        }
        
        
        
        
        
/***********************************************************************/
//                  이하 터치금지                                         //
/***********************************************************************/
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

