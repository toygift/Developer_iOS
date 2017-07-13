//
//  MemoTableController.swift
//  MemoAlone_More
//
//  Created by jaeseong Lee on 2017. 7. 10..
//  Copyright © 2017년 jaeseong Lee. All rights reserved.
//
/*********************************************메모*********************************************/
// 1차시도 테이블뷰 셀 커스텀 하기..
// numberOFRowsInSection  갯수 - > 일수
// numberOfSections 갯수 -> 월수
/*********************************************메모*********************************************/
import UIKit

class MemoTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
   
    
    var memoList = [String]()
    
    var userDefault = UserDefaults.standard.array(forKey: "MEMO")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse") as! MemoTableViewCell
        let inputMemo = cell.inputMemoText.text
        memoList.append(inputMemo!)
        UserDefaults.standard.set(memoList, forKey: "MEMO")
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
