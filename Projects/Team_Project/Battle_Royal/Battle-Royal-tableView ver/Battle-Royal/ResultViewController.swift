//
//  ResultViewController.swift
//  Battle-Royal
//
//  Created by 유하늘 on 2017. 6. 15..
//  Copyright © 2017년 유하늘. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    /*********************************************************************************************************************/
    //                                                 변수선언                                                          //
    /*********************************************************************************************************************/
    
    var cost:Int = 0 // 총 금액
    var resultList:[String]? // 메인뷰 에서 받은 배열
    var remainAdded:Bool = false
    var makeIt: [String] = [] // 함수 결과값 저장 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cost = self.cost
        let resultList = self.resultList ?? []
        let winnerIndex = getWinnerIndex(index: UInt32(resultList.count))
        let winnerIndexInt = Int(winnerIndex)
        
        makeIt = makeResult(list: resultList, winnername: resultList[winnerIndexInt], cost: cost)
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
    func makeResult(list: [String],winnername: String,cost: Int) -> [String] {//-> String
        
        var resultMoney2 = [String]()
        
        for name in list {
            if name == winnername {
                resultMoney2.append("0")
            }else {
                resultMoney2.append(String(distributeCost(cost: cost, num: list.count - 1)))
            }
            
        }
        
        return resultMoney2
    }
    
    /*********************************************************************************************************************/
    //                                                 분배함수                                                          //
    /*********************************************************************************************************************/
    
    // 교윤코딩
    func distributeCost (cost: Int, num: Int) -> Int {
        
        var remain: Int = 0
        var amount: Int = 0
        
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
    //                                                 테이블 뷰                                                         //
    /*********************************************************************************************************************/
    
    //재성 코딩
    //원래 결과값이 텍스트 뷰로 출력하게 만들었었는데
    //테이블뷰에 출력되도록 수정함
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell: ResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "secondCell") as! ResultTableViewCell
        
        cell.resultName?.text = resultList?[indexPath.row]
        cell.resultMoney?.text = makeIt[indexPath.row]
        
        return cell
    }
    
    /*********************************************************************************************************************/
    //                                                 didReceiveMemoryWarning()                                         //
    /*********************************************************************************************************************/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
