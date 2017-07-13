//
//  MemoTableController.swift
//  MemoAlone
//
//  Created by jaeseong Lee on 2017. 7. 10..
//  Copyright © 2017년 jaeseong Lee. All rights reserved.
//
/*********************************************메모*********************************************/
// 1차시도 기본적인 테이블뷰 생성, Delegate연결, DataSource연결 -> cell identifier 입력
// -> 삽질 이유! Document Outline에서 delegate, DataSource연결을 안해줌..젠장
//
/*********************************************메모*********************************************/



import UIKit

class MemoTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var memoReceiveAarray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(memoReceiveAarray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.memoReceiveAarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse")!
        
        cell.textLabel?.text = self.memoReceiveAarray[indexPath.row]
        
        
        return cell
    }

}
