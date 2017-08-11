//
//  ListViewController.swift
//  Table-Cellheight
//
//  Created by 이재성 on 2017. 6. 15..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ListViewController : UITableViewController {
    
    var list = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "목록입력", message: "추가될글을 작성하세요", preferredStyle: .alert)
        
        alert.addTextField() {
            (tf) in
            tf.placeholder = "내용을 입력하세요"
        }
        
        let ok = UIAlertAction(title: "OK", style: .default){
            (_) in
            
            if let title = alert.textFields?[0].text {
                self.list.append(title)
                self.tableView.reloadData()
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: false)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        let row = self.list[indexPath.row]
//        
//        let height = CGFloat(60 + (row.characters.count / 30) * 20)
//        
//        return height
//    }
    
}
