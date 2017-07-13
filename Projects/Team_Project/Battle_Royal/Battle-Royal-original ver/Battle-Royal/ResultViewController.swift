//
//  ResultViewController.swift
//  Battle-Royal
//
//  Created by 유하늘 on 2017. 6. 15..
//  Copyright © 2017년 유하늘. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    /*********************************************************************************************************************/
    //                                                 변수선언                                                          //
    /*********************************************************************************************************************/
    
    @IBOutlet weak var textViewResult: UITextView!
    
    var cost:Int = 0 // 총 금액
    var resultList:[String]? // 메인뷰 에서 받은 배열
    var remainAdded:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let cost = self.cost
        let resultList = self.resultList ?? []
        
        print(cost)
        print(resultList) //배열
        
        let winnerIndex = getWinnerIndex(index: UInt32(resultList.count))
        
        let winnerIndexInt = Int(winnerIndex)
        
        print(winnerIndexInt)
        print("winner: \(resultList[winnerIndexInt])")
        
        if resultList == [] {
            textViewResult.text = "입력한 내용이 없습니다."
        } else {
            let finalResult = makeResult(list: resultList, winnername: resultList[winnerIndexInt], cost: cost)
            
            textViewResult.text = finalResult
        }
    }
    /*********************************************************************************************************************/
    //                                                 랜덤함수                                                          //
    /*********************************************************************************************************************/
    
    
    // 하늘 코딩
    func getWinnerIndex(index: UInt32) -> UInt32 {
        let ranNum: UInt32 = arc4random_uniform(index)

        return ranNum
    }
    /*********************************************************************************************************************/
    //                                                 결과함수                                                          //
    /*********************************************************************************************************************/
    
    
    // 1차 코딩 유하늘
    func makeResult(list: [String],winnername: String,cost: Int) -> String {
        
        var result: String = "Final Result \n"
        
        for name in list {
            if name == winnername {
                result += "Winner : \(name) 지불금액 : 0원! \n"
            }else{
                result += "Loser  : \(name) 지불금액 : \(distributeCost(cost: cost, num: list.count - 1)) \n"
            }
        }
        return result
    }
    /*********************************************************************************************************************/
    //                                                 분배함수                                                          //
    /*********************************************************************************************************************/
    
    // 교윤코딩
    func distributeCost (cost: Int, num: Int) -> Int {
        
        var remain: Int = 0
        var amount: Int = 0
        
        
        // 10000원 / 3명 
        // 10000 / 3 = 3333 => 3334 ??
        remain = cost % num
        
        if remainAdded == false {
            amount = cost / num
            amount += remain
            remainAdded = true
        } else {
            amount = cost / num
        }
        
        return amount
        
    }
    
    /*********************************************************************************************************************/
    //                                                 didReceiveMemoryWarning()                                         //
    /*********************************************************************************************************************/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
